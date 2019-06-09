import 'package:flutter/material.dart';

class InformationSheetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(
              child: Container(
                width: 24.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
          ),
          Text(
            'Информация',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'Возможны сокращения интервалов движения поездов. Данные получены из официального сайта метрополитена г. Алматы.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Автор',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'kekland',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Почта',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'kk.erzhan@gmail.com',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Версия приложения',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            '0.1.0 (beta)',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
