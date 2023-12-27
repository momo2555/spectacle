/* eslint-disable */
const FILARMONIC_URL = "ws://localhost:2225"

class SocketClientService {

    constructor() {
        this.ws = new WebSocket(FILARMONIC_URL);
        this.device = "spectacle";
        this.initEvents();
        this.startGameCallbacks = [];

    }

    initEvents() {
        this.ws.addEventListener('open', (e) => {
            this.identification();
        });
        this.ws.onmessage = (e) => {
            let data = JSON.parse(e.dat);
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
        let mkeys = message.keys();
        if(mkeys.includes("header")) {
            let header = message["header"];
            let hkeys = header.keys();
            if(hkeys.includes("type")) {
              let type = header["type"];
              // is a request 
              if(type == "request") {
                if(message["params"]["exec"] != undefined && message["params"]["exec"] == "launchGame") {
                    this.execStartGame();
                }
              }  
            }
        }
    }

    onStartGame(callback) {
        this.startGameCallbacks.push(callback)
    }

    execStartGame() {

    }


}

export default {
    install (app) {
        var filarmonic = new SocketClientService();
        app.config.globalProperties.$filarmonic = filarmonic;
    }
}