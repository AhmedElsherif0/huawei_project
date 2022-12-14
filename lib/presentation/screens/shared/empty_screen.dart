import 'package:flutter/material.dart';
import '../../widgets/buttons/elevated_button.dart';


class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 5),
            const Expanded(
              flex: 10,
              child: Image(
                image: AssetImage('assets/images/empty_Gif.gif'),
                gaplessPlayback: true,
              ),
            ),
            Expanded(
              child: Text(
                'No Expenses yet',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                text: 'Back',
                onPressed: () {},
                icon: Icons.arrow_back_ios,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                text: 'Add',
                onPressed: () {},
                icon: Icons.add,
              ),
            ),
            const Spacer(flex: 6),
          ],
        ),
      ),
    );
  }
}
