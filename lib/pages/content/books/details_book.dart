import 'dart:math';

import 'package:bibliobook/models/book_case/book.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsBook extends StatefulWidget {
  final Book bookDetails;

  DetailsBook({Key? key, required this.bookDetails}) : super(key: key);

  @override
  _DetailsBookState createState() => _DetailsBookState();
}

class _DetailsBookState extends State<DetailsBook> {
  bool _showLongDescription = false;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del libro"),
        actions: [
          IconButton(
            tooltip: "Visitar webpage",
            icon: Icon(Icons.public),
            onPressed: () {
              //TODO: implementar web view o abrir con el navegador (opcional)
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => WebViewPage(
              //       url: widget.bookDetails.volumeInfo.previewLink,
              //     ),
              //   ),
              // );
              _launchURL(widget.bookDetails!.volumeInfo!.previewLink!);
            },
          ),
          IconButton(
            tooltip: "Compartir",
            icon: Icon(Icons.share),
            onPressed: () {
              // TODO: implemente el Share de contenido con otras apps
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(24),
              height: MediaQuery.of(context).size.height * .4,
              child: Hero(
                tag: widget!.bookDetails!.id!,
                child: Image.network(
                  widget.bookDetails!.volumeInfo!.imageLinks!.thumbnail!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              widget.bookDetails.volumeInfo!.title ?? "No title",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.bookDetails.volumeInfo!.categories != null
                    ? widget.bookDetails.volumeInfo!.categories!.length
                    : 0,
                (index) => Text(
                  "${widget.bookDetails.volumeInfo!.authors![index]!}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Text(
              widget.bookDetails.volumeInfo!.publishedDate ?? "No date",
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Paginas: ${widget.bookDetails.volumeInfo!.pageCount ?? "No disponibles"}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              children: List.generate(
                widget.bookDetails.volumeInfo!.categories != null
                    ? widget.bookDetails.volumeInfo!.categories!.length
                    : 0,
                (index) => Chip(
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  label: Text(
                    "${widget.bookDetails.volumeInfo!.categories![index]}",
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: _showLongDescription
                  ? Text(
                      widget.bookDetails.volumeInfo!.description ??
                          "No description",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  : Text(
                      widget.bookDetails.volumeInfo!.description ??
                          "No description available",
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
              onTap: () {
                setState(() {
                  _showLongDescription = !_showLongDescription;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
