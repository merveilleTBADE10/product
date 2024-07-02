import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class descrip extends StatefulWidget {
  const descrip({super.key});

  @override
  State<descrip> createState() => _descripState();
}

class _descripState extends State<descrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF674AEF),
        iconTheme: IconThemeData(color: Colors.white),
        // leading en blanc
        title: Text(
          "About us",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFF2F2F2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            //je doit mettre le lien email
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure accusantium necessitatibus rerum, explicabo harum eligendi fugiat dicta corporis. Labore voluptatibus repudiandae inventore consequatur pariatur mollitia dolorum, reprehenderit adipisci! Itaque, molestias!Dolorum quam tempore dolore sapiente provident cupiditate commodi incidunt? Sit dicta nam, earum maiores fuga architecto distinctio laboriosam omnis exercitationem repellat! Expedita tenetur cupiditate a quidem aut qui, consequatur ea!Exercitationem voluptatibus ipsa quia vel modi reiciendis nesciunt inventore possimus optio minima explicabo nemo, eligendi qui aspernatur temporibus? Voluptas error velit repudiandae. Adipisci eaque natus praesentium laboriosam, nam aliquid odit?Odit numquam, tenetur corporis architecto quasi, ipsa quia voluptas debitis consectetur voluptate accusamus aperiam ullam sed molestias enim esse minima et! Deserunt quisquam, aperiam doloribus itaque quis quidem libero quod.Architecto quod sapiente magni quo atque veniam optio eos dolorum, sequi id sit maxime, omnis beatae repudiandae dolor ducimus facilis nulla porro consequatur iusto quaerat quibusdam! Eligendi atque quidem voluptatem!Enim ex temporibus assumenda eius quaerat dolor asperiores libero minima vero, fugit ratione ut laborum in, quam quisquam laudantium et cumque eos exercitationem alias sint. Libero error nostrum dicta cumque!Nam esse, pariatur facere non consectetur dolor aut recusandae ad neque dolorem harum nostrum delectus, reiciendis quaerat? Commodi odit deleniti maxime, ut exercitationem, temporibus aut unde id tenetur aliquid cum.Facilis sapiente quaerat libero laboriosam doloribus dolores? Optio enim quod nisi quidem hic rerum nulla aliquam reprehenderit fugit veritatis ex vitae atque eius ipsam praesentium maxime iste, autem quo natus.Distinctio maiores quidem nesciunt tempore consequatur ipsum, assumenda doloribus quod cupiditate neque explicabo totam rerum repellat corrupti consequuntur suscipit deleniti voluptatibus, ullam natus nemo minima sed pariatur dolore soluta? Sapiente.Molestiae adipisci est tempora maxime architecto necessitatibus magnam hic nisi officiis. Illo, possimus impedit expedita quaerat dignissimos molestiae laboriosam similique et sunt omnis pariatur molestias! Sit, exercitationem voluptates? Maiores, quasi",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Email : francis@gmail.com",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.blue),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Tel : +228 99856233",
                                style: TextStyle(color: Colors.blue),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
