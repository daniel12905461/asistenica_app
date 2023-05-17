import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connectToSocket() {
    socket = IO.io('http://192.168.0.14:8000/sio/sockets');

    socket.onConnect((_) {
      print('Conectado al backend');
    });

    socket.on('ubicacion', (data) {
      // Aquí recibes los datos de ubicación actualizados desde el backend
      print('Nueva ubicación recibida: $data');
    });

    socket.onDisconnect((_) {
      print('Desconectado del backend');
    });

    socket.connect();
  }

  void emitUbicacion(double latitud, double longitud) {
    socket.emit('ubicacion', {
      'latitud': latitud,
      'longitud': longitud,
    });
  }

  void closeSocket() {
    socket.disconnect();
  }
}
