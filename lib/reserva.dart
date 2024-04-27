// Define una clase para representar una reserva
class Reserva {
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String tipoHabitacion;
  final int numeroPersonas;

  Reserva({
    required this.fechaInicio,
    required this.fechaFin,
    required this.tipoHabitacion,
    required this.numeroPersonas,
  });
}