import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_basic_builder.dart';
import 'package:protibeshi_app/views/others/space_horizontal.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

final middleCardList=[];
final subCategoryList = ["Product","Service","Teaching"];
class ReceivedCard extends StatelessWidget {
  const ReceivedCard({Key? key, required this.userId, required this.offer}) : super(key: key);
  final String userId ;
  final OfferModel offer;
   @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 380,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(.5),
              width: 1.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child:  Center (
            child: Column(
              children:   [
                Heading(userId: userId),
                const MiddleCard(),
                Details(offer:offer),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                   [
                    TextButton(
                    onPressed: () => print("object"),
                    child: const Text("Details"),),
                    const SpaceHorizontal(20),
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(onPressed: (){
                    
                      }, child: const Text("Accept")),
                    )
                  ],
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context) {
    return UserBasicBuilder(
      userId: userId,
      builder: (context,user,isOnline) {
        return UserPictureBuilder(
          userId: userId,
          builder: (context,profilePic,coverPic) {
         //   return UserLocationBuilder(
           //   builder: (context,locationList) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 3),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              clipBehavior: Clip.hardEdge,
                              child: Container(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.40),
                                child: profilePic.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Icon(
                                          Icons.person,
                                          size: 60,
                                        ),
                                      )
                                    : Hero(
                                        tag: profilePic.first.imageUrl,
                                        child: CachedNetworkImage(
                                          imageUrl: profilePic.first.imageUrl,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                    const SpaceHorizontal(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name??"No name"),
                        const Text("Level 2 seller"),
                        const Text("200ft away"),
                        const Text("5 hours left to respond"),
                      ],
                    ),
                    const SpaceHorizontal(5),
                    Row(
                      children: const [
                        Icon(Icons.verified),
                        Text("Verified")
                      ],
                    )
                  ],
                );
             // }
            //);
          }
        );
      }
    );
  }
}
class MiddleCard extends StatelessWidget {
  const MiddleCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(.5),
              width: 1.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child:  Center (
            child: Row(
              children:   [
                  Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 3),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              clipBehavior: Clip.hardEdge,
                              child: Container(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.40),
                                child:  const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Icon(
                                          Icons.book,
                                          size: 50,
                                        ),
                                      )
                                
                              ),
                            ),
                          ),
                  const SpaceHorizontal(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("Lord of the Rings"),
                    Text("by J. R. R. Tolkien"),
                  ],) 
              ],
            )
          ),
        ),
      ),
    );
 
  }
}

class Details extends StatelessWidget {
  const Details({Key? key, required this.offer}) : super(key: key);
  final OfferModel offer;
  @override
  Widget build(BuildContext context) {
    final name = offer.rentUpdateInformation!=null ? "Book rent" : "Book sell";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
           children: [
            TextWithTitle(title: "Category", text: name),
            const SpaceVertical(5),
            const TextWithTitle(title: "Start Date/ Time", text: "10 Oct, 5:00 pm"),
            const SpaceVertical(5),
            const TextWithTitle(title: "Duration", text: "2 days"),
            const SpaceVertical(5),
            const TextWithTitle(title: "Total", text: "350 tk"),
            const SpaceVertical(5),
           ],
    
      ),
    );
  }
}

class TextWithTitle extends StatelessWidget {
  const TextWithTitle({Key? key, required this.title, required this.text}) : super(key: key);
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(title)),
        Text(text)  
      ],
    );
  }
}