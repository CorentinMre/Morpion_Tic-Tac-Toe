import sys
import os

#For the Game
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

    # Signals To Send Data
    status = Signal(str)
    grille = Signal(list)
    win = Signal()

    # Function PlayVsComputer
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
            self.game.bestMoveForAI()
            self.game.whoPlay = "O" if self.game.whoPlay == "X" else "X" #Changement de joueur pour que le suivant joue
            self.grille.emit(self.game.grille)
        self.status.emit(f"Au tour de '{self.game.whoPlay}'")
        

    @Slot(int)
    def nextRound(self, move:int):
        """
        Go to the next round
        """
        
        if not self.game.checkWin(self.game.grille) and not self.game.checkEquality():
        
            self.game.placeInTheGrille(move)
            
            self.game.tour += 1

            if self.game.checkWin(self.game.grille): self.status.emit(f"Nous avons un gagnant ! '{self.game.whoPlay}' a gagné."); self.win.emit()
            elif self.game.checkEquality(): self.status.emit("Egalité"); self.win.emit()
            
            self.game.whoPlay = "O" if self.game.whoPlay == "X" else "X" #Changement de joueur pour que le suivant joue
            
            if self.game.playWithAI == True and self.game.whoPlay == self.game.computerOrPlayer2:
                self.game.tour += 1
                self.game.bestMoveForAI()
                if self.game.checkWin(self.game.grille): self.status.emit(f"Nous avons un gagnant ! '{self.game.whoPlay}' a gagné."); self.win.emit()
                elif self.game.checkEquality(): self.status.emit("Egalité"); self.win.emit()
                self.game.whoPlay = "O" if self.game.whoPlay == "X" else "X" #Changement de joueur pour que le suivant joue

            if not self.game.checkWin(self.game.grille) and not self.game.checkEquality():
                self.status.emit(f"Au tour de '{self.game.whoPlay}'")
                
            self.grille.emit(self.game.grille)
                
                
            

            
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
