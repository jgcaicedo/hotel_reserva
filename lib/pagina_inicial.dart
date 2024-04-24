import 'package:flutter/material.dart';
import 'package:hoteles_reserva/conexion.dart';
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


// late CalendarController _calendarController;
 

  String? selectedValue ;
  int selectedNumber = 1;
  


  @override
  Widget build(BuildContext context) {
    
     Conexion.data("?Metodo=destinos");
    return Scaffold(body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,children: [
              Text("Destino:"),
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
                    List<String> options=['Seleccionar'] ;
                   
                    options.addAll( data.map((item) => item['nombre']).cast<String>().toList());

                     selectedValue = options.isNotEmpty ? options[0] : '';

                    return Column(
                      children: [
                        DropdownButton<String>(
                          value: selectedValue,
                          items: options.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
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
                "${seleccionarFechaLlegada.toLocal()}".split(' ')[0],
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

                    print(data);
                    List<String> options = data.map((item) => item['tipo']).cast<String>().toList();

                   
                    String selectedValue = options.isNotEmpty ? options[0] : '';

                    return Column(
                      children: [
                        DropdownButton<String>(
                          value: selectedValue,
                          items: options.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
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



          ElevatedButton(onPressed: (){}, child: Text("Buscar Reservas")),


         
          TableCalendar(
           calendarFormat: CalendarFormat.month,firstDay: seleccionarFechaLlegada, focusedDay: seleccionarFechaLlegada, lastDay: seleccionarFechaIda,
          )
           
    


  
          

          

        ],
      ),
    ),);
  }
}