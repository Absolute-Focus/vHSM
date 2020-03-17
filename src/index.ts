import 'reflect-metadata';
import {ApiServer} from './server/index';


const server = new ApiServer();
server.start(+process.env.PORT || 8080);