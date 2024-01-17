/* eslint-disable */
const FILARMONIC_URL = "ws://localhost:2225"

class SocketClientService {

    constructor() {
        this.ws = new WebSocket(FILARMONIC_URL);
        this.device = "spectacle";
        this.initEvents();
        this.startGameCallbacks = [];
        this.closeGameCallbacks = [];

    }

    initEvents() {
        this.ws.addEventListener('open', (e) => {
            this.identification();
        });
        this.ws.onmessage = (e) => {
            let data = JSON.parse(e.data);
            this.receive(data);
        };
        
    }

    identification() {
        let dataToSend = {
            header : {
                type: "identification",
                from: this.device,
            },
        };
        this.ws.send(JSON.stringify(dataToSend));
    }

    receive(message) {
        console.log("Receive new message");
        if(message["header"]!=undefined) {
            let header = message["header"];

            console.log(header);
            if(header["type"]!=undefined) {
              let type = header["type"];
              // is a request 
              if(type == "request") {
                console.log(message["request"])
                if(message["request"]["exec"] != undefined && message["request"]["exec"] == "game_started") {
                    this.execStartGame();
                    console.log("Start Game")    
                } 
                if(message["request"]["exec"] != undefined && message["request"]["exec"] == "closeGame") {
                    this.execCloseGame();
                }
              }  
            }
        }
    }

    onStartGame(callback) {
        this.startGameCallbacks.push(callback)
    }

    execStartGame() {
        for(let callback of this.startGameCallbacks) {
            callback();
        }
    }

    onCloseGame(callback) {
        this.closeGameCallbacks.push(callback)
    }

    execCloseGame() {
        for(let callback of this.closeGameCallbacks) {
            callback();
        }
    }

}

export default {
    install (app) {
        var filarmonic = new SocketClientService();
        app.config.globalProperties.$filarmonic = filarmonic;
    }
}