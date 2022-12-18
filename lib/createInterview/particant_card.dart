// ignore_for_file: unnecessary_import, sized_box_for_whitespace, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, non_constant_identifier_names, prefer_typing_uninitialized_variables


import 'package:flutter/material.dart';

class ParticipantList extends StatefulWidget {
  final data;
  final selected;
  const ParticipantList({Key? key, required this.data,required this.selected}) : super(key: key);

  @override
  State<ParticipantList> createState() => _ParticipantListState();
}

class _ParticipantListState extends State<ParticipantList> {
  bool isSelected = false;
  Future<void> chekstatus() async{
    if(widget.selected.contains(widget.data['pId'].toString().trim())){
      setState(() {
        isSelected=true;
      });
    } else {
      setState(() {
        isSelected=false;
      });
    }
  }
  
  Future<void> selectParticipant() async{
    if(isSelected){
      setState(() {
        isSelected=false;
        widget.selected.remove(widget.data['pId'].toString().trim());
      });
    } else {
      setState(() {
        isSelected=true;
        widget.selected.add(widget.data['pId'].toString().trim());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    chekstatus();
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Card(
        color: isSelected?Color.fromARGB(255, 221, 221, 221): Color.fromARGB(255, 235, 235, 235),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Student Details',
                    style: TextStyle(
                      color: Colors.indigo.shade900,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 145,
                  ),
                  Container(
                    // color: Colors.red,
                    height: 25,
                    width: 25,
                    child: IconButton(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        selectParticipant();
                      },
                      icon: Icon(Icons.check_box),
                      color: isSelected?Color.fromARGB(255, 0, 166, 6):Colors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Name: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                      child: Text(
                    widget.data['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  )),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Email: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      widget.data['email'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'College Name: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      widget.data['college'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Branch: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      "${widget.data['branch']} (${widget.data['pass_year']})",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Marks: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      widget.data['mark'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resume: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      'Link',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
