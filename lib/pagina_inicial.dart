import 'package:flutter/material.dart';
import 'package:hoteles_reserva/conexion.dart';
import 'package:hoteles_reserva/reserva.dart';
//import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';


class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  
  @override
  void initState() {
    super.initState();
  }
  List<Reserva> reservas = [];
 

   DateTime seleccionarFechaLlegada = DateTime.now(); 
   DateTime seleccionarFechaIda = DateTime.now(); 

   Future<void> _seleccionarFechaLlegada(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: seleccionarFechaLlegada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != seleccionarFechaLlegada) {
      setState(() {
        seleccionarFechaLlegada = picked;
      });
    }
  }

   Future<void> _seleccionarFechaIda(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: seleccionarFechaIda,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != seleccionarFechaIda) {
      setState(() {
        seleccionarFechaIda = picked;
      });
    }
  }


//late CalendarController _calendarController;
 

  String? selectedValue ;
  String? _selectedValueDos ;

  int selectedNumber = 1;
  


  @override
  Widget build(BuildContext context) {
    
    //  Conexion.data("?Metodo=destinos");
    return Scaffold(
      body: Center(
      child: Container(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text("Destinos:"),
                  SizedBox(
                  width: 5,
                  ),
                  FutureBuilder(
                    future: Conexion.data('?Metodo=destinos'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final data = snapshot.data as List<dynamic>;
                        List<String> options = ['Seleccionar'];

                        options.addAll(data.map((item) => item['nombre'] as String));

                        // Utilizamos una nueva variable local para mantener el valor seleccionado temporalmente
                        String? tempSelectedValue = selectedValue;

                        // Si no hay valor seleccionado, seleccionamos el primer elemento de la lista
                        

                        return Column(
                          children: [
                            DropdownButton<String>(
                              value: tempSelectedValue,
                              hint: Text("Seleccionar"),
                              items: options.map((String option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  // Actualizamos el valor seleccionado cuando cambia
                                  selectedValue = newValue;
                                });
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text("Fecha de llegada:"),
                  
                  Text(
                    "${seleccionarFechaLlegada.toLocal()}".split(' ')[0],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  
                  IconButton(onPressed: () => _seleccionarFechaLlegada(context), icon: const Icon(Icons.calendar_month))
                  
                  ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text("Fecha de Ida:"),
                  
                  Text(
                    "${seleccionarFechaIda.toLocal()}".split(' ')[0],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  
                  IconButton(onPressed: () => _seleccionarFechaIda(context), icon: const Icon(Icons.calendar_month))
                 
                  ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Tipo de Habitacion:"),
                  FutureBuilder(
      future: Conexion.data('?Metodo=tipos&IdDestino=${selectedValue}'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data as List<dynamic>;
          
          List<String> options = [];
          options.addAll(data.map((item) => item['tipo'] as String));
             
         // String _selectedValueDos = options.isNotEmpty ? options[0] : '';
          // if (selectedValue=="Seleccionar") {
          //     String? tempSelectedValue="Seleccionar";  
          // }else
          String? tempSelectedValue = _selectedValueDos ;
         

          return Column(
            children: [
              DropdownButton<String>(
                value: tempSelectedValue,
                hint: Text("Seleccionar"),

                items: options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                setState(() {
                  _selectedValueDos = newValue!;
                });
              },
              ),
            ],
          );
        }
      },
    )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text("Numero de personas:"),
                  
                  DropdownButton<int>(
                    value: selectedNumber,
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedNumber = newValue!;
                      });
                    },
                    items: List<DropdownMenuItem<int>>.generate(
                      100,
                      (int index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text((index + 1).toString()),
                        );
                      },
                    ),
                  )
                ],
              ),
          
              SizedBox(height: 200,),
          
          
          
              ElevatedButton(onPressed: (){
                  setState(() {
                    reservas.add(Reserva(
                    fechaInicio: seleccionarFechaLlegada,
                    fechaFin: seleccionarFechaIda,
                    tipoHabitacion: selectedValue!,
                    numeroPersonas: selectedNumber,
                  ));
                });
                //funcion reservar
              }, 
              child: Text("Buscar Reservas")),
          
          
             
              TableCalendar(
               calendarFormat: CalendarFormat.month,firstDay: seleccionarFechaLlegada, focusedDay: seleccionarFechaLlegada, lastDay: seleccionarFechaIda,
               calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  // Aquí puedes personalizar la apariencia de los marcadores de fecha
                  // Por ejemplo, podrías verificar si la fecha tiene una reserva y agregar un marcador
                  for (var reserva in reservas) {
                    if (date.isAfter(reserva.fechaInicio.subtract(Duration(days: 1))) &&
                        date.isBefore(reserva.fechaFin.add(Duration(days: 1)))) {
                      return Container(
                        width: 5,
                        height: 5,
                        color: Colors.blue,
                      );
                    }
                  }
                  return null;
                },
               )
              )
               
              
          
          
            
              
          
              
          
            ],
          ),
        ),
      ),
    ),);
  }
}