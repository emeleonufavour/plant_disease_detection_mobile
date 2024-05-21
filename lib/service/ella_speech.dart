import 'dart:math';

class EllaService {
  Random random = Random();
  String sayIdentifiedDisease(String disease) {
    List<String> varaitions = [
      "The diagnosed disease is $disease \n",
      "The findings indicate the disease is $disease \n",
      "The disease has been identified as $disease \n",
      "The disease is $disease \n",
      "The test results show the disease is $disease \n",
      "The disease has been confirmed as $disease \n"
    ];

    int randomIndex = random.nextInt(varaitions.length);

    return varaitions[randomIndex];
  }

  String proposeAdvice() {
    List<String> variations = [
      "May I offer a suggestion?   \n",
      "Here is a suggestion  \n",
      "I'd like to put forth a recommendation  \n",
      "Permit me to recommend a solution   \n",
      "How about considering this solution   \n",
      "I think you should try this   \n"
    ];

    int randomIndex = random.nextInt(variations.length);

    return variations[randomIndex];
  }

  String saySolutionForRust() {
    List<String> variations = [
      """
Try implementing a regular crop rotation schedule to disrupt the life cycle of 
rust fungi and reduce the buildup of pathogens in the soil. \n
 """,
      """
Do plant rust-resistant cultivars whenever possible to minimize the impact of the disease on crops.\n
 """,
      """
Make sure to pply fungicides preventatively, especially during periods of high humidity or when rust symptoms first appear.
 Timely application can help control the spread of the disease.\n
 """,
      """
At times, remove and destroy infected plant debris to eliminate potential sources of
 rust spores and reduce the risk of future infections.\n
 """,
      """
Do well to regularly inspect crops for signs of rust infection and take prompt action to implement control measures when necessary.
 Early detection allows for more effective management of the disease.\n
 """,
    ];
    int randomIndex = random.nextInt(variations.length);

    return variations[randomIndex];
  }
}
