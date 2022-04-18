
class Morpion:
    def __init__(self, player1, whoStart, playWithAI):
        #Création de la grille
        self.grille  = [" " for _ in range(9)]
        #Initialisation des signes en fonctions des jouurs
        self.player1 = player1 # "X" or "O"
        self.computerOrPlayer2 = "O" if self.player1 == "X" else "X" # "X" or "O"
        self.whoPlay = whoStart # "X" or "O"
        #Initialisation du nombre de tour à 0
        self.tour = 0
        #Initialisation de la partie gagnée à False
        self.isWin = False
        #Joueur contre l'ordinateur
        self.playWithAI = playWithAI
        
        


    def displayGrille(self):
        """
        Affichage de la grille
        
        ╔═══╦═══╦═══╗
        ║   ║   ║   ║
        ╠═══╬═══╬═══╣
        ║   ║   ║   ║
        ╠═══╬═══╬═══╣
        ║   ║   ║   ║
        ╚═══╩═══╩═══╝
           
        """
        
        print("   ╔═══╦═══╦═══╗")
        print("   ║ " + self.grille[0] + " ║ " + self.grille[1] + " ║ " + self.grille[2] + " ║")
        print("   ╠═══╬═══╬═══╣")
        print("   ║ " + self.grille[3] + " ║ " + self.grille[4] + " ║ " + self.grille[5] + " ║")
        print("   ╠═══╬═══╬═══╣")
        print("   ║ " + self.grille[6] + " ║ " + self.grille[7] + " ║ " + self.grille[8] + " ║")
        print("   ╚═══╩═══╩═══╝")


    def checkWin(self, grille):
        """
        Vérification d'une victoire

        Returns:
            bool: Renvoie True si la partie est gagnée, sinon False
        
        
        Pour vérifier une victoire, on doit vrifier si la grille contient 3 symboles identiques dans une ligne, une colonne ou une diagonale
        """
        
        #Vérification des lignes puis colonnes puis diagonales
        if grille[0] == grille[1] == grille[2] != " " \
        or grille[3] == grille[4] == grille[5] != " " \
        or grille[6] == grille[7] == grille[8] != " " \
                                                      \
        or grille[0] == grille[3] == grille[6] != " " \
        or grille[1] == grille[4] == grille[7] != " " \
        or grille[2] == grille[5] == grille[8] != " " \
                                                      \
        or grille[0] == grille[4] == grille[8] != " " \
        or grille[2] == grille[4] == grille[6] != " ":
            return True
        else: return False
        
    def checkEquality(self):
        """
        Vérifie si la partie nulle

        Returns:
            bool: Renvoie True si la partie est nulle, sinon False
        
        
        Si la partie admet une égalité (nulle), elle comporte + ou = à 9 tours
        """
        
        return self.tour >= 9
        
    def placeInTheGrille(self, move:int):
        """
        Place le coup du joueur dans la grille si il est possible

        Args:
            move (int): Case de la grille où le joueur veut jouer

        Returns:
            bool: Renvoie True si le coup a été placé, sinon False
        
        
        Si le coup du joueur qui joue est possible, on place le symbole dans la case et on renvoie True, sinon on renvoie False
        """
    
        if self.grille[move] == " ":
            self.grille[move] = self.whoPlay
            return True
        else: return False


    def bestMoveForAI(self):
        """
        Meilleur coup pour l'ordinateur
        
        Cette fonction doit créer une grille virtuelle,
        
        - Pour voir si un coup est potentiellement gagnant en ramplant chaque " " 
        de la grille virtuelle par le symbole de l'ordinateur, pour voir si le coup donné par l'ordi peut etre gagnant, si non,
        on remet " " à la place du symbole mis par l'ordi.
        
        - Puis on vérifie la même chose pour le joueur, pour pouvoir le bloqué.
        
        - Sinon, on essaye de jouer le meilleur coup possible.
            -> On joue au centre si possible dès le second tour
            -> Si le joueur joue un angle, on joue sur l'arrête dans le sens des aiguilles d'une montre (si possible)
                Ex:
                        Si le joueur = "X", l'ordinateur = "O"
                    
                        ╔═══╦═══╦═══╗           ╔═══╦═══╦═══╗
                        ║ X ║   ║   ║           ║ X ║   ║   ║
                        ╠═══╬═══╬═══╣           ╠═══╬═══╬═══╣
                        ║   ║   ║   ║       ->  ║ O ║   ║   ║
                        ╠═══╬═══╬═══╣           ╠═══╬═══╬═══╣
                        ║   ║   ║   ║           ║   ║   ║   ║
                        ╚═══╩═══╩═══╝           ╚═══╩═══╩═══╝
                        
                        ╔═══╦═══╦═══╗           ╔═══╦═══╦═══╗
                        ║   ║   ║   ║           ║   ║   ║   ║
                        ╠═══╬═══╬═══╣           ╠═══╬═══╬═══╣
                        ║   ║   ║   ║       ->  ║   ║   ║   ║
                        ╠═══╬═══╬═══╣           ╠═══╬═══╬═══╣
                        ║ X ║   ║   ║           ║ X ║ O ║   ║
                        ╚═══╩═══╩═══╝           ╚═══╩═══╩═══╝
                        
                        ╔═══╦═══╦═══╗           ╔═══╦═══╦═══╗
                        ║   ║   ║   ║           ║   ║   ║   ║
                        ╠═══╬═══╬═══╣           ╠═══╬═══╬═══╣
                        ║   ║   ║   ║       ->  ║   ║   ║ O ║
                        ╠═══╬═══╬═══╣           ╠═══╬═══╬═══╣
                        ║   ║   ║ X ║           ║   ║   ║ X ║
                        ╚═══╩═══╩═══╝           ╚═══╩═══╩═══╝
                        
                        ╔═══╦═══╦═══╗           ╔═══╦═══╦═══╗
                        ║   ║   ║ X ║           ║   ║ O ║ X ║
                        ╠═══╬═══╬═══╣           ╠═══╬═══╬═══╣
                        ║   ║   ║   ║       ->  ║   ║   ║   ║
                        ╠═══╬═══╬═══╣           ╠═══╬═══╬═══╣
                        ║   ║   ║   ║           ║   ║   ║   ║
                        ╚═══╩═══╩═══╝           ╚═══╩═══╩═══╝
                        
            -> Sinon en tente de jouer dans les angles si possible
        
        """
        grille = self.grille
        # On regarde le meilleur coup pour l' ordinateur
    
        for i in range(len(self.grille)):
            
            if grille[i] == " ":
                grille[i] = self.whoPlay
                if self.checkWin(grille):
                    self.grille[i] = self.whoPlay
                    return
                else:
                    grille[i] = " "
                    
                    
        # On vérifie si le joueur peut gagner au prochain tour
        
        joueur1 = "O" if self.whoPlay == "X" else "X"
        
        for i in range(len(self.grille)):
            if grille[i] == " ":
                grille[i] = joueur1
                if self.checkWin(grille):
                    self.grille[i] = self.whoPlay
                    return
                else:
                    grille[i] = " "
            
        # Sinon l'ordinateur joue son meilleur coup
        
        
        # tentative de jouer au centre sauf au deuxieme tour si l'ordinateur commence à jouer
        if self.tour > 1:
            if self.placeInTheGrille(4) : return
        
        # tentative de jouer sur les arretes si le joueur joue dans les coins
        posPlayer = [i for i, x in enumerate(grille) if x == self.player1]

        if 0 in posPlayer:
            if self.placeInTheGrille(3) : return
        if 2 in posPlayer:
            if self.placeInTheGrille(1) : return 
        if 6 in posPlayer:
            if self.placeInTheGrille(7): return
        if 8 in posPlayer:
            if self.placeInTheGrille(5): return
            
            
        # tentative de jouer dans les coins
        if self.placeInTheGrille(0): return
        if self.placeInTheGrille(2): return
        if self.placeInTheGrille(6): return
        if self.placeInTheGrille(8): return
        

def clear():
    """
    Efface le contenu de la console
    """
    system('cls' if name == 'nt' else 'clear')
        


if __name__ == "__main__":
    
    #importation des fonctions 'system' et 'name' de la bibliothèque 'os' pour effacer le contenu de la console
    from os import system, name
    
    
    
    #Efface le terminal
    clear()
    
    while True:
        playWithAI = input("[?] Voulez-vous jouer contre l'ordinateur ? (y/n) : ")
        if playWithAI == "y":
            playWithAI = True
            break
        elif playWithAI == "n":
            playWithAI = False
            break
    
    while True:
        signe = input("\n[?] Quel est le signe du joueur qui commence à jouer ? (x/o) : ")
        if signe.upper() == "X":
            player1 = "X"
            computerOrPlayer2 = "O"
            break
        elif signe.upper() == "O":
            player1 = "O"
            computerOrPlayer2 = "X"
            break
    
    while True:
        first = input(f"\n[?] Joueur '{player1}', voulez vous commencer a jouer ? (y/n) : ")
        if first == "y":
            whoStart = player1
            break
        elif first == "n":
            whoStart = computerOrPlayer2
            break
    
    # Initialisation du jeu
    game = Morpion(player1, whoStart, playWithAI)
    
    #Pour ne pas afficher d'erreur dans le terminal si le joueur fait un Ctrl+C pour quitter le programme
    try:
        
        while not game.isWin and not game.checkEquality():

            #Efface le terminal
            clear()

            #Affichage de la grille
            game.displayGrille()
            
            if game.playWithAI == True and game.whoPlay == game.computerOrPlayer2:
                game.bestMoveForAI()
            else:
                
                #Affichage du nom du joueur
                print(f"\n[!] Au tour de '{game.whoPlay}'")
                
                #Vérification de la validité du coup joué
                while True:
                    move = int(input("[?] Où Voulez-vous jouer? Veuillez rentrer un nombre de 1 à 9: ")) - 1 # car la grille est une liste de 0 à 8
                    if game.placeInTheGrille(move): break
                    else: print("\n[?] La case déjà occupée, choisissez-en une autre.")
                
            #Vérification de la victoire
            if game.checkWin(game.grille): game.isWin = True
            else: game.whoPlay = "O" if game.whoPlay == "X" else "X" #Changement de joueur pour que le suivant joue
            game.tour += 1

        #Efface le terminal
        clear()
        #Affichage de la grille
        game.displayGrille()
        #GAGNANT
        if game.isWin: print(f"\n[!] Nous avons un gagnant! {game.whoPlay} a gagné.")
        else: print("\n[!] Égalité")

    except KeyboardInterrupt:
        print('\n\n[!] Combat interrompu!')