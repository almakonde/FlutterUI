import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class InputFormScreen extends StatefulWidget {
  @override
  _InputFormScreenState createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  String _password;
  String _date;
  double _number;
  File _imagePath;


  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);



    if (pickedFile != null) {
      setState(() {
        _imagePath = File(pickedFile.path); // выбранное изображение
      });
    }
  }

  bool isValidDateFormat(String input) {
    try {
      final dateTime = DateTime.parse(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Текстовое поле'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Поле не может быть пустым';
              }
              return null;
            },
            onSaved: (value) => _name = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Пароль'),
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Поле не может быть пустым';
              }
              if (value.length < 6) {
                return 'Пароль должен содержать как минимум 6 символов';
              }
              return null;
            },
            onSaved: (value) => _password = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Дата'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Поле даты не может быть пустым';
              }
              if (!isValidDateFormat(value)) {
                return 'Некорректный формат даты';
              }
              return null;
            },
            onSaved: (value) => _date = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Цифровое поле'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty || double.tryParse(value) == null) {
                return 'Введите корректное число';
              }
              return null;
            },
            onSaved: (value) => _number = double.parse(value),
          ),
          // Поле загрузки изображения
          InkWell(
            onTap: () {
              _pickImage();
            },
            child: Column(
              children: <Widget>[
                Icon(Icons.camera_alt),
                Text('Загрузить изображение'),
              ],
            ),
          ),
          // Кнопка для подтверждения введенных данных.
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // Манипуляция с данными, например, отправка их на сервер.
              }
            },
            child: Text('Подтвердить'),
          ),
          // код для отображения выбранного изображения
          if (_imagePath != null)
            Image.file(
              File(_imagePath.path),
              width: 100,
              height: 100,
            ),
        ],
      ),
    );
  }
}
