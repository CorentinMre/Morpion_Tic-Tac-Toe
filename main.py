import sys
import os

#Utilisation de 'Thread' et 'sleep' pour faire un delay après que le joueur joue (le delay est de .15 secondes)
#ce n'est pas obligatoire, mais pour une meilleure expérience, il est preferable de faire comme ceci (même si le jeu devient un peu plus lourd)
from time import sleep
from threading import Thread

#Importation de la classe 'Morpion'
from morpion import Morpion

# IMPORT MODULES
from PySide6.QtGui import QGuiApplication, QIcon
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal

# Main Window Class
class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.game = None
        self.pos = None

    # Signals To Send Data
    status = Signal(str)
    grille = Signal(list, int)
    win = Signal()
    move = Signal(list, int)

    # Function Start Game
    @Slot(str, str, bool)
    def start(self, signePlayer1:str, whoStart:str, playWithComputer:bool):
        """
        Start a new game with a other player

        Args:
            signePlayer1 (str): sign of player 1
            whoStart (str): who start the game
            playWithComputer (bool)
        """
        self.game = Morpion(signePlayer1, whoStart, playWithComputer)
        if self.game.playWithAI == True and self.game.whoPlay == self.game.computerOrPlayer2:
            self.game.tour += 1
            move = self.game.bestMoveForAI()
            if self.game.checkWin(self.game.grille): self.status.emit(f"Nous avons un gagnant ! '{self.game.whoPlay}' a gagné."); self.win.emit()
            elif self.game.checkEquality(): self.status.emit("Egalité"); self.win.emit()
            self.game.whoPlay = "O" if self.game.whoPlay == "X" else "X" #Changement de joueur pour que le suivant joue
            sleep(.15)
            self.move.emit(self.game.grille, move)
        self.status.emit(f"Au tour de '{self.game.whoPlay}'")
        

    @Slot(int)
    def nextRound(self, move:int):
        """
        Go to the next round

        Args:
            move (int): l'emplacement du coup joué
        """
        self.pos = move
        def nextRound():#Fonction pour le thread
            if not self.game.checkWin(self.game.grille) and not self.game.checkEquality():
            
                self.game.placeInTheGrille(self.pos)
                
                self.game.tour += 1

                if self.game.checkWin(self.game.grille): self.status.emit(f"Nous avons un gagnant ! '{self.game.whoPlay}' a gagné."); self.win.emit()
                elif self.game.checkEquality(): self.status.emit("Egalité"); self.win.emit()
                
                self.game.whoPlay = "O" if self.game.whoPlay == "X" else "X" #Changement de joueur pour que le suivant joue

                #self.grille.emit(self.game.grille, 0) #1 = ordinateur, 0 = joueur
                self.move.emit(self.game.grille, self.pos)

                if self.game.playWithAI == True and self.game.whoPlay == self.game.computerOrPlayer2:
                    self.game.tour += 1
                    move = self.game.bestMoveForAI()
                    if self.game.checkWin(self.game.grille): self.status.emit(f"Nous avons un gagnant ! '{self.game.whoPlay}' a gagné."); self.win.emit()
                    elif self.game.checkEquality(): self.status.emit("Egalité"); self.win.emit()
                    self.game.whoPlay = "O" if self.game.whoPlay == "X" else "X" #Changement de joueur pour que le suivant joue
                    sleep(.15)
                    self.move.emit(self.game.grille, move)

                    
                    

                if not self.game.checkWin(self.game.grille) and not self.game.checkEquality():
                    self.status.emit(f"Au tour de '{self.game.whoPlay}'")
                    
        #Thread pour faire un delay après que le joueur joue
        round = Thread(target=nextRound)
        round.start()

            
# INSTACE CLASS
if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setWindowIcon(QIcon("images/iconMorpion.png"))
    engine = QQmlApplicationEngine()

    # Get Context
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    # Load QML File
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    # Check Exit App
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
