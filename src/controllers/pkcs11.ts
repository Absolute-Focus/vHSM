import {Controller} from './controller';
import {HttpServer} from '../server/httpServer';
import {Request, Response} from 'restify';
var pkcs11js = require("pkcs11js");
var p11 = new pkcs11js.PKCS11();
p11.load("/usr/local/lib/softhsm/libsofthsm2.so");

export class Pkcs11 implements Controller {
    
    public initialize(httpServer: HttpServer): void {
        httpServer.get('/c_initialize', this.c_initialize.bind(this));
    }

    private async c_initialize(req: Request, res: Response): Promise<void> {
        res.send(await p11.C_Initialize());
    }
}