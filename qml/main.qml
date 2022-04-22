import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Window{
    id: window
    width: 400
    height: 580
    x : Screen.width / 2 - width / 2
    y : Screen.height / 2 - height / 2
    visible: true
    color: "#00ffffff"
    title: qsTr("Morpion")

    property bool playWithComputer: true

    // SET FLAGS
    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint | Qt.CustomizeWindowHint | Qt.MSWindowsFixedSizeDialogHint | Qt.WindowTitleHint | Qt.Window | Qt.FramelessWindowHint

    // SET MATERIAL STYLE
    Material.theme: Material.Dark
    Material.accent: Material.LightBlue
    FontLoader { id: alfaSlabOneFont; source: "../images/fonts/Alfa_Slab_One/AlfaSlabOne.ttf" }

    

    // Internal functions
    QtObject{
        id: internal

        function play(){
            
            btnBackHome.visible = false
            imgCase1.source = ""
            imgCase2.source = ""
            imgCase3.source = ""
            imgCase4.source = ""
            imgCase5.source = ""
            imgCase6.source = ""
            imgCase7.source = ""
            imgCase8.source = ""
            imgCase9.source = ""
            btnCase1.hoverEnabled = true
            btnCase2.hoverEnabled = true
            btnCase3.hoverEnabled = true
            btnCase4.hoverEnabled = true
            btnCase5.hoverEnabled = true
            btnCase6.hoverEnabled = true
            btnCase7.hoverEnabled = true
            btnCase8.hoverEnabled = true
            btnCase9.hoverEnabled = true
            backend.start(switchForSigne.text, switchSigneForWhoStart.text, playWithComputer)
            recPlay.visible = true
            recHome.visible = false

        }

        function retourPlay(){
            recHome.visible = true
            recPlay.visible = false
            recHelp.visible = false
        }
        function aide(){
            recHelp.visible = true
            recPlay.visible = false
            recHome.visible = false
        }
        function retourAide(){
            recPlay.visible = true
            recHelp.visible = false
            recHome.visible = false
        }

    }


    Image {
        id: background
        x: 0
        y: 35
        anchors.fill: parent
        source: "../images/bg.jpg"
        fillMode: Image.TileHorizontally
    


    Rectangle {
        id: recHome
        x: 0
        width: 400
        height: 545
        visible: true
        color: "#00ffffff"
        anchors.top: parent.top
        anchors.topMargin: 35

        Rectangle {
            id: recLogo
            x: 60
            height: 221
            color: "#9069fa"
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 60
            anchors.leftMargin: 66
            anchors.topMargin: 26
            anchors.rightMargin: 65

            Image{
                id: imgLogo
                x: 78
                y: 23
                width: 124
                height: 124
                source: "../images/logoMorpion.png"
                anchors.horizontalCenterOffset: -1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 28
            }

            Text{
                id: lblNameApp
                x: 79
                y: 158
                width: 123
                height: 63
                text: qsTr("Morpion")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font { family: alfaSlabOneFont.name; pointSize: 17}
                anchors.verticalCenterOffset: 79
                anchors.horizontalCenterOffset: 7
                color: "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter

            }
        }

        Switch {
            id: switchPlayWithBotOrPlayer
            x: 150
            y: 279
            width: 101
            height: 30
            layer.enabled: false
            
            onClicked : {
                if (switchPlayWithBotOrPlayer.checked) {
                    lblNameOfRec.text = "Jouer à deux"
                    lblSign.visible = false
                    switchForSigne.visible = false
                    lblWhoStart.x = 140
                    switchSigneForWhoStart.x = 141
                    playWithComputer = false
                }
                else {
                    lblNameOfRec.text = "Jouer contre l'ordinateur"
                    lblSign.visible = true
                    switchForSigne.visible = true
                    lblWhoStart.x = 238
                    switchSigneForWhoStart.x = 238
                    playWithComputer = true
                }
            }
        }

        Rectangle {
            id: recStart
            x: 8
            y: 315
            width: 384
            height: 222
            visible: true
            color: "#00ffffff"
            Button {
                id: btnPlay
                x: 42
                y: 161
                width: 98
                height: 46
                opacity: 1
                text: qsTr("Jouer")
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 15
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                z: 0
                onClicked: internal.play()
            }

            Rectangle {
                id: recNameOfRec
                x: 60
                height: 40
                color: "#9069fa"
                radius: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 60
                anchors.rightMargin: 60
                anchors.topMargin: 24
                anchors.leftMargin: 60
                Text {
                    id: lblNameOfRec
                    color: "#ffffff"
                    text: qsTr("Jouer contre l'ordinateur")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.top: parent.top
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.topMargin: 12
                    font.pointSize: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            SwitchDelegate {
                id: switchForSigne
                x: 38
                width: 103
                height: 32
                text: "X"
                anchors.top: lblSign.bottom
                anchors.topMargin: 14

                onClicked : {
                    if (switchForSigne.checked) {
                        switchForSigne.text = "O"
                    }
                    else {
                        switchForSigne.text = "X"
                    }
                }
            }

            Text {
                id: lblSign
                color: "#ffffff"
                text: qsTr("Quel signe veux-tu?")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: recNameOfRec.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 224
                anchors.leftMargin: 30
                anchors.topMargin: 21
                anchors.verticalCenterOffset: -18
                font.pointSize: 10
            }

            SwitchDelegate {
                id: switchSigneForWhoStart
                x: 238
                width: 103
                height: 32
                text: "X"
                anchors.top: lblSign.bottom
                anchors.topMargin: 14
                onClicked: {
                    if (switchSigneForWhoStart.checked) {
                        switchSigneForWhoStart.text = "O"
                    }
                    else {
                        switchSigneForWhoStart.text = "X"
                    }
                }
            }

            Text {
                id: lblWhoStart
                x: 238
                color: "#ffffff"
                text: qsTr("Qui commence?")
                anchors.verticalCenter: parent.verticalCenter
                anchors.top: recNameOfRec.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 10
                anchors.topMargin: 21
                anchors.verticalCenterOffset: -18
            }
        }


    }




    Rectangle {
        id: recPlay
        visible: false
        color: "#00ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 35

        Rectangle {
            id: recInfo
            color: "#9069fa"
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 60
            anchors.bottomMargin: 428
            anchors.rightMargin: 50
            anchors.leftMargin: 60
            anchors.topMargin: 46
            Text {
                id: lblInfo
                width: 274
                height: 54
                color: "#ffffff"
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pointSize: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Button {
            id: btnBackPlay
            x: 16
            width: 79
            height: 37
            opacity: 1
            text: qsTr("Retour")
            anchors.top: parent.top
            anchors.topMargin: 500
            z: 0
            onClicked: internal.retourPlay()
        }

        Button {
            id: btnHelp
            x: 313
            width: 79
            height: 37
            opacity: 1
            text: qsTr("Aide")
            anchors.top: parent.top
            anchors.topMargin: 500
            z: 0
            onClicked: internal.aide()
        }

        Image {
            id: imgBackgroundMorpion
            x: 60
            y: 160
            width: 290
            height: 255
            source: "../images/backgroundMorpion.png"
            cache: true
            fillMode: Image.PreserveAspectFit


            Button {
                id: btnCase1
                x: 61
                y: 39
                width: 55
                height: 60
                text: qsTr("")
                highlighted: true
                topInset: 0
                flat: true

                onClicked: {
                    if (imgCase1.source == "") {
                        backend.nextRound(0)
                    }
                }

                Image {
                    id: imgCase1
                    x: 20
                    y: 27
                    anchors.fill: parent
                    source: ""
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    anchors.topMargin: 5
                    anchors.bottomMargin: 5
                    fillMode: Image.PreserveAspectFit
                }
            }

            Button {
                id: btnCase2
                x: 122
                y: 39
                width: 55
                height: 60
                text: qsTr("")
                highlighted: true
                topInset: 0
                flat: true

                onClicked: {
                    if (imgCase2.source == "") {
                        backend.nextRound(1)
                    }
                }

                Image {
                    id: imgCase2
                    x: 20
                    y: 27
                    anchors.fill: parent
                    source: ""
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    anchors.topMargin: 5
                    anchors.bottomMargin: 5
                    fillMode: Image.PreserveAspectFit
                }
            }

            Button {
                id: btnCase3
                x: 183
                y: 39
                width: 55
                height: 60
                text: qsTr("")
                highlighted: true
                topInset: 0
                flat: true

                onClicked: {
                    if (imgCase3.source == "") {
                        backend.nextRound(2)
                    }
                }

                Image {
                    id: imgCase3
                    x: 20
                    y: 27
                    anchors.fill: parent
                    source: ""
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    anchors.bottomMargin: 5
                    anchors.topMargin: 5
                    fillMode: Image.PreserveAspectFit
                }
            }

            Button {
                id: btnCase4
                x: 61
                y: 100
                width: 55
                height: 60
                text: qsTr("")
                highlighted: true
                topInset: 0
                flat: true
                onClicked: {
                    if (imgCase4.source == "") {
                        backend.nextRound(3)
                    }
                }

                Image {
                    id: imgCase4
                    x: 20
                    y: 27
                    anchors.fill: parent
                    source: ""
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    anchors.bottomMargin: 5
                    anchors.topMargin: 5
                    fillMode: Image.PreserveAspectFit
                }
            }

            Button {
                id: btnCase5
                x: 122
                y: 100
                width: 55
                height: 60
                text: qsTr("")
                highlighted: true
                topInset: 0
                flat: true
                onClicked: {
                    if (imgCase5.source == "") {
                        backend.nextRound(4)
                    }
                }

                Image {
                    id: imgCase5
                    x: 20
                    y: 27
                    anchors.fill: parent
                    source: ""
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    anchors.bottomMargin: 5
                    anchors.topMargin: 5
                    fillMode: Image.PreserveAspectFit
                }
            }

            Button {
                id: btnCase6
                x: 183
                y: 100
                width: 55
                height: 60
                text: qsTr("")
                highlighted: true
                topInset: 0
                flat: true

                onClicked: {
                    if (imgCase6.source == "") {
                        backend.nextRound(5)
                    }
                }

                Image {
                    id: imgCase6
                    x: 20
                    y: 27
                    anchors.fill: parent
                    source: ""
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    anchors.bottomMargin: 5
                    anchors.topMargin: 5
                    fillMode: Image.PreserveAspectFit
                }
            }

            Button {
                id: btnCase7
                x: 61
                y: 161
                width: 55
                height: 60
                text: qsTr("")
                highlighted: true
                topInset: 0
                flat: true

                onClicked: {
                    if (imgCase7.source == "") {
                        backend.nextRound(6)
                    }
                }

                Image {
                    id: imgCase7
                    x: 20
                    y: 27
                    anchors.fill: parent
                    source: ""
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    anchors.bottomMargin: 5
                    anchors.topMargin: 5
                    fillMode: Image.PreserveAspectFit
                }
            }

            Button {
                id: btnCase8
                x: 122
                y: 161
                width: 55
                height: 60
                text: qsTr("")
                highlighted: true
                topInset: 0
                flat: true

                onClicked: {
                    if (imgCase8.source == "") {
                        backend.nextRound(7)
                    }
                }

                Image {
                    id: imgCase8
                    x: 20
                    y: 27
                    anchors.fill: parent
                    source: ""
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    anchors.bottomMargin: 5
                    anchors.topMargin: 5
                    fillMode: Image.PreserveAspectFit
                }
            }

            Button {
                id: btnCase9
                x: 183
                y: 161
                width: 55
                height: 60
                text: qsTr("")
                highlighted: true
                topInset: 0
                flat: true

                onClicked: {
                    if (imgCase9.source == "") {
                        backend.nextRound(8)
                    }
                }

                Image {
                    id: imgCase9
                    x: 20
                    y: 27
                    anchors.fill: parent
                    source: ""
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    anchors.bottomMargin: 5
                    anchors.topMargin: 5
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Button {
            id: btnBackHome
            x: 128
            width: 154
            height: 57
            opacity: 1
            visible: false
            text: qsTr("Revenir à l'acceil")
            anchors.top: parent.top
            z: 0
            anchors.topMargin: 433

            onClicked: internal.retourPlay()
        }


    }

    Rectangle {
        id: recHelp
        visible: false
        color: "#00ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 35

        Rectangle {
            id: recRules
            x: 66
            y: 274
            width: 269
            height: 203
            color: "#9069fa"
            radius: 10
            anchors.margins: 60
            Text {
                id: lblExplication1
                width: 245
                height: 180
                color: "#ffffff"
                text: qsTr("Deux joueurs posent tour à tour un rond, pour l’un, une croix, pour l’autre, dans une grille de 3 cases par 3. Le but du jeu est d’obtenir un alignement (en ligne, colonne ou diagonale) de ses trois signes.")
                anchors.verticalCenter: parent.verticalCenter
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                anchors.bottomMargin: 17
                font.pointSize: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Button {
            id: btnBackHelp
            x: 16
            width: 79
            height: 37
            opacity: 1
            text: qsTr("Retour")
            anchors.top: parent.top
            anchors.topMargin: 500
            z: 0
            onClicked: internal.retourAide()
        }

        Rectangle {
            id: recLogo2
            x: 60
            height: 221
            color: "#9069fa"
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 60
            Image {
                id: imgLogo2
                x: 78
                y: 23
                width: 124
                height: 124
                anchors.top: parent.top
                source: "../images/logoMorpion.png"
                anchors.horizontalCenterOffset: -1
                anchors.topMargin: 28
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: lblNameApp2
                x: 79
                y: 158
                width: 123
                height: 63
                color: "#ffffff"
                text: qsTr("Morpion")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 17
                anchors.horizontalCenterOffset: 7
                anchors.verticalCenterOffset: 79
                font.family: alfaSlabOneFont.name
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.leftMargin: 66
            anchors.topMargin: 26
            anchors.rightMargin: 65
        }
    }

    Rectangle {
        id: recTopBar
        x: 0
        y: 0
        width: 400
        height: 35
        color: "#151515"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top


        Image {
            id: iconApp
            width: 36
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "../images/iconMorpion.png"
            anchors.leftMargin: 3
            anchors.bottomMargin: 3
            anchors.topMargin: 3
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: recBtns
            x: 330
            width: 70
            height: 35
            visible: true
            color: "#00ffffff"
            anchors.right: parent.right
            anchors.top: parent.top




            Button {
                id: btnMin
                width: 35
                height: 47
                opacity: 1
                text: qsTr("—")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                font.underline: false
                font.strikeout: false
                flat: true
                font.italic: true
                font.bold: true
                font.family: "LED Real"
                font.pointSize: 15
                anchors.leftMargin: 0
                z: 0
                onClicked: window.showMinimized()
            }

            Button {
                id: btnClose
                x: 35
                width: 35
                height: 47
                opacity: 1
                text: "\u2715"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                down: false
                flat: true
                font.italic: false
                font.bold: false
                font.pointSize: 17
                font.family: "ChromiumAATTest"
                anchors.rightMargin: 0
                z: 0
                onClicked: window.close()
            }
        }

        Label {
            id: lblNameOfGame
            x: 46
            width: 241
            color: "#c3cbdd"
            text: qsTr("Morpion")
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            anchors.rightMargin: 113
            font.pointSize: 10
            anchors.leftMargin: 5
        }

        DragHandler {
            onActiveChanged: if(active){
                                 window.startSystemMove()
                             }
        }

    }
    }//end backgroundImage


    Connections {
        target: backend


        function onStatus(info){lblInfo.text=info}

        function onGrille(grille){

            if(grille[0] === "X"){
                imgCase1.source = "../images/cross.png"
                btnCase1.hoverEnabled = false
            }else if(grille[0] === "O"){
                imgCase1.source = "../images/circle.png"
                btnCase1.hoverEnabled = false
            }
            
            if(grille[1] === "X"){
                imgCase2.source = "../images/cross.png"
                btnCase2.hoverEnabled = false
            }else if(grille[1] === "O"){
                imgCase2.source = "../images/circle.png"
                btnCase2.hoverEnabled = false
            }

            if(grille[2] === "X"){
                imgCase3.source = "../images/cross.png"
                btnCase3.hoverEnabled = false
            }else if(grille[2] === "O"){
                imgCase3.source = "../images/circle.png"
                btnCase3.hoverEnabled = false
            }

            if(grille[3] === "X"){
                imgCase4.source = "../images/cross.png"
                btnCase4.hoverEnabled = false
            }else if(grille[3] === "O"){
                imgCase4.source = "../images/circle.png"
                btnCase4.hoverEnabled = false
            }

            if(grille[4] === "X"){
                imgCase5.source = "../images/cross.png"
                btnCase5.hoverEnabled = false
            }else if(grille[4] === "O"){
                imgCase5.source = "../images/circle.png"
                btnCase5.hoverEnabled = false
            }

            if(grille[5] === "X"){
                imgCase6.source = "../images/cross.png"
                btnCase6.hoverEnabled = false
            }else if(grille[5] === "O"){
                imgCase6.source = "../images/circle.png"
                btnCase6.hoverEnabled = false
            }

            if(grille[6] === "X"){
                imgCase7.source = "../images/cross.png"
                btnCase7.hoverEnabled = false
            }else if(grille[6] === "O"){
                imgCase7.source = "../images/circle.png"
                btnCase7.hoverEnabled = false
            }

            if(grille[7] === "X"){
                imgCase8.source = "../images/cross.png"
                btnCase8.hoverEnabled = false
            }else if(grille[7] === "O"){
                imgCase8.source = "../images/circle.png"
                btnCase8.hoverEnabled = false
            }

            if(grille[8] === "X"){
                imgCase9.source = "../images/cross.png"
                btnCase9.hoverEnabled = false
            }else if(grille[8] === "O"){
                imgCase9.source = "../images/circle.png"
                btnCase9.hoverEnabled = false
            }

        }
        function onWin(){
            btnBackHome.visible = true
        }

    }

}