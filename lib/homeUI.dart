// ignore_for_file: prefer_const_constructors, file_names

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_js_notes/models/noteModel.dart';
import 'package:flutter_js_notes/providers/notesProvider.dart';
import 'package:flutter_js_notes/screens/newNote.dart';
import 'package:provider/provider.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  void initState() {
    super.initState();
    // DynamicTheme.of(context)!.setTheme(1);
  }

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Notes'),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            isMainView: true,
            title: Text(
              'Notes',
              style: TextStyle(
                color: Theme.of(context).textTheme.headline6!.color,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              <Widget>[
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  addAutomaticKeepAlives: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: notesProvider.notes.length,
                  itemBuilder: ((context, index) {
                    Note currentNote = notesProvider.notes[index];
                    if (notesProvider.notes.isEmpty) {
                      return Text('No Notes');
                    }
                    return noteCard(currentNote, context);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewNoteUI(
                isUpdate: false,
                note: null,
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget noteCard(Note currentNote, BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewNoteUI(
                      isUpdate: true,
                      note: currentNote,
                    )));
      },
      onLongPress: () {
        notesProvider.deleteNote(currentNote);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentNote.title!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                currentNote.content!,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  final Widget title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool isMainView;
  final Function()? onBackButtonPressed;

  const CustomSliverAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.bottom,
    this.isMainView = false,
    this.onBackButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 100.0,
      automaticallyImplyLeading: !isMainView,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(
          bottom: bottom != null ? 16.0 : 14.0,
          left: isMainView ? 20.0 : 55.0,
        ),
        title: title,
      ),
      leading: isMainView
          ? null
          : IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).textTheme.headline6!.color,
              ),
              onPressed:
                  onBackButtonPressed ?? () => Navigator.of(context).pop(),
            ),
      backgroundColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.scrolledUnder)
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).canvasColor,
      ),
      actions: actions,
      bottom: bottom,
    );
  }
}
