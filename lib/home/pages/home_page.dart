import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late var tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        slivers: [
          const Encabezado(),
          const EncabezadoDeLista(),
          const ListaDeCanchas(),
          EncabezadoDias(tabController: tabController),
          ReservacionTabView(tabController: tabController)
        ],
      ),
    );
  }
}

class EncabezadoDias extends StatelessWidget {
  final TabController tabController;
  const EncabezadoDias({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 20),
      sliver: SliverToBoxAdapter(
        child: TabBar(
            controller: tabController,
            indicatorColor: Colors.green[700],
            tabs: const [
              Text(
                'LUN',
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
              Text(
                'MAR',
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
              Text(
                'MIE',
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
              Text(
                'JUE',
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
              Text(
                'VIE',
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
              Text(
                'SAB',
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
              Text(
                'DOM',
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ]),
      ),
    );
  }
}

class ReservacionTabView extends StatelessWidget {
  final TabController tabController;
  const ReservacionTabView({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      fillOverscroll: true,
      child: TabBarView(
          physics: BouncingScrollPhysics(),
          controller: tabController,
          children: [
            ReservacionPorDiaList(),
            ReservacionPorDiaList(),
            ReservacionPorDiaList(),
            ReservacionPorDiaList(),
            ReservacionPorDiaList(),
            ReservacionPorDiaList(),
            ReservacionPorDiaList(),
          ]),
    );
  }
}

class ReservacionPorDiaList extends StatelessWidget {
  const ReservacionPorDiaList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ReservacionCard(),
        ReservacionCard(),
        ReservacionCard(),
      ],
    );
  }
}

class ReservacionCard extends StatelessWidget {
  const ReservacionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Colors.green,
            )),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month,
              size: 45,
              color: Colors.green[900],
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reservado por: Angel Mambel'),
                Text(
                    'Fecha de reserva: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}'),
                Text(
                    'Hora de reserva: ${DateFormat('hh:mm').format(DateTime.now())}'),
              ],
            )
          ],
        ));
  }
}

class ListaDeCanchas extends StatelessWidget {
  const ListaDeCanchas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 180,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          scrollDirection: Axis.horizontal,
          children: const [
            CanchaCard(
              titulo: 'Cancha "A"',
              imagen: 'assets/img/canchaa.jpg',
            ),
            CanchaCard(
              titulo: 'Cancha "B"',
              imagen: 'assets/img/canchab.jpg',
            ),
            CanchaCard(
              titulo: 'Cancha "C"',
              imagen: 'assets/img/canchac.jpg',
            ),
          ],
        ),
      ),
    );
  }
}

class CanchaCard extends StatelessWidget {
  final String titulo;
  final String imagen;
  const CanchaCard({
    Key? key,
    required this.titulo,
    required this.imagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) => Container(
          //height: 400 + MediaQuery.of(context).viewInsets.bottom,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10
          ),
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Reservar $titulo'),
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text('Nombre de la persona'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime.now().subtract(const Duration(days: 1000)),
                    lastDate: DateTime.now().add(const Duration(days: 1000))
                  );
                  await showTimePicker(
                    context: context, 
                    initialTime: TimeOfDay(
                      hour: TimeOfDay.now().hour,
                      minute: TimeOfDay.now().minute,
                    ),
                  );
                },
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    label: Text('Fecha de la reserva'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                ),
              ),
              const SizedBox(height: 30),
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: const EdgeInsets.all(20),
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                ),
                fillColor: Theme.of(context).colorScheme.primary,
                child: const Text(
                  'Reservar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: (){

                }
              )
            ],
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(5),
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.orange,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagen,
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.color,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EncabezadoDeLista extends StatelessWidget {
  const EncabezadoDeLista({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.only(top: 0, left: 20, bottom: 5),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Lista de canchas',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Encabezado extends StatelessWidget {
  const Encabezado({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      expandedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(18),
        centerTitle: false,
        title: Text(
          'Reservas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        stretchModes: [
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
          StretchMode.zoomBackground,
        ],
      ),
    );
  }
}
