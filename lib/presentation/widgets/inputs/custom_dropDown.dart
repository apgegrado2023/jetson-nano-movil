/*import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/config/utils/validators.dart';
import 'package:flutter_application_prgrado/data/models/user.dart';
import 'package:intl/intl.dart';

class SettingsWidget<T> extends StatefulWidget {
  final List<DropdownInfo<T>> items;
  final String? Function(DropdownInfo<T>?) validator;
  final String hint;
  final String? cabecera;
  final Icon? icon;
  final void Function(DropdownInfo<T>) onChanged;
  final dynamic initialValue; // Valor inicial definido por el usuario

  const SettingsWidget({
    required this.items,
    required this.hint,
    this.cabecera,
    this.icon,
    required this.onChanged,
    required this.validator,
    this.initialValue, // Parámetro adicional para el valor inicial
    Key? key,
  }) : super(key: key);

  @override
  _SettingsWidgetState<T> createState() => _SettingsWidgetState<T>();
}

class _SettingsWidgetState<T> extends State<SettingsWidget<T>> {
  dynamic _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DropdownInfo<T>>(
      initialValue: _currentItem,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.cabecera != null)
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    widget.cabecera!,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<DropdownInfo<T>>(
                  value: _currentItem,
                  hint: Text(widget.hint),
                  items: _buildDropdownMenuItems(),
                  onChanged: (value) {
                    if (widget.validator != null) {
                      state.setValue(value);
                      state.validate();
                    }
                    setState(() {
                      _currentItem = value;
                    });
                    widget.onChanged(value!);
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1.7,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1.7,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    prefixIcon: widget.icon,
                  ),
                ),
              ),
              if (state.hasError)
                Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 194, 18, 18),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<DropdownInfo<T>>> _buildDropdownMenuItems() {
    return widget.items
        .map<DropdownMenuItem<DropdownInfo<T>>>((DropdownInfo<T> item) {
      return DropdownMenuItem<DropdownInfo<T>>(
        value: item,
        child: Text(item.tag),
      );
    }).toList();
  }
}

class SettingsWidgetText<T> extends StatefulWidget {
  final List<T> items;
  final String? Function(T?) validator;
  final String hint;
  final String? cabecera;
  final Icon? icon;
  final void Function(T) onChanged;
  final dynamic initialValue; // Valor inicial definido por el usuario

  const SettingsWidgetText({
    required this.items,
    required this.hint,
    this.cabecera,
    this.icon,
    required this.onChanged,
    required this.validator,
    this.initialValue, // Parámetro adicional para el valor inicial
    Key? key,
  }) : super(key: key);

  @override
  _SettingsWidgetStateText<T> createState() => _SettingsWidgetStateText<T>();
}

class _SettingsWidgetStateText<T> extends State<SettingsWidgetText<T>> {
  dynamic _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: _currentItem,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.cabecera != null)
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    widget.cabecera!,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<T>(
                  value: _currentItem,
                  hint: Text(widget.hint),
                  items: _buildDropdownMenuItems(),
                  onChanged: (value) {
                    if (widget.validator != null) {
                      state.setValue(value);
                      state.validate();
                    }
                    setState(() {
                      _currentItem = value;
                    });
                    widget.onChanged(value!);
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1.7,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1.7,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    prefixIcon: widget.icon,
                  ),
                ),
              ),
              if (state.hasError)
                Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 194, 18, 18),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<T>> _buildDropdownMenuItems() {
    return widget.items.map<DropdownMenuItem<T>>((T item) {
      return DropdownMenuItem<T>(
        value: item,
        child: Text(
          item.toString(),
        ),
      );
    }).toList();
  }
}

class DateOfBirthComboBox extends StatefulWidget {
  final void Function(DateTime)? onChanged;

  DateOfBirthComboBox({required this.onChanged});

  @override
  _DateOfBirthComboBoxState createState() => _DateOfBirthComboBoxState();
}

class _DateOfBirthComboBoxState extends State<DateOfBirthComboBox> {
  late String selectedDay;
  late String selectedMonth;
  late String selectedYear;

  List<String> days = List.generate(31, (index) => (index + 1).toString());
  List<String> months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  List<String> years = List.generate(100, (index) => (2023 - index).toString());

  @override
  void initState() {
    super.initState();
    selectedDay = days.first;
    selectedMonth = months.first;
    selectedYear = years.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final comboWidth = (constraints.maxWidth - 20) / 3;

          return Row(
            children: [
              Expanded(
                child: Container(
                  width: comboWidth,
                  child: buildComboBox(days, 'Día', selectedDay, (newValue) {
                    setState(() {
                      selectedDay = newValue!;
                    });
                    emitDateOfBirth();
                  }),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  width: comboWidth,
                  child:
                      buildComboBox(months, 'Mes', selectedMonth, (newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                    emitDateOfBirth();
                  }),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  width: comboWidth,
                  child: buildComboBox(years, 'Año', selectedYear, (newValue) {
                    setState(() {
                      selectedYear = newValue!;
                    });
                    emitDateOfBirth();
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildComboBox(List<String> items, String label, String selectedValue,
      void Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      //value: selectedValue,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,

      validator: (value) {
        return Validators.validationNull(value);
      },
      decoration: InputDecoration(
        hintText: label,
        contentPadding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1.7,
            style: BorderStyle.solid,
            color: Color.fromARGB(255, 218, 218, 218),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1.7,
            style: BorderStyle.solid,
            color: Color.fromARGB(255, 218, 218, 218),
          ),
        ),
      ),
    );
  }

  void emitDateOfBirth() {
    final int day = int.parse(selectedDay);
    final int month = months.indexOf(selectedMonth) + 1;
    final int year = int.parse(selectedYear);
    final dateOfBirth = DateTime(year, month, day);
    if (widget.onChanged != null) {
      widget.onChanged!(dateOfBirth);
    }
  }
}

class DateSelector extends StatefulWidget {
  final Function(DateTime)? onChanged;

  DateSelector({this.onChanged});

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now(); // Fecha inicial
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onChanged?.call(selectedDate); // Llamar al evento onChanged
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: TextStyle(fontSize: 16.0),
            ),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}

class DateOfBirthInput extends StatefulWidget {
  @override
  _DateOfBirthInputState createState() => _DateOfBirthInputState();
}

class _DateOfBirthInputState extends State<DateOfBirthInput> {
  TextEditingController _dayController = TextEditingController();
  TextEditingController _monthController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  bool isFormValid = false;

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isFormValid = validateForm();

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _dayController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Day',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                isFormValid = validateForm();
              });
            },
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _monthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Month',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                isFormValid = validateForm();
              });
            },
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _yearController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Year',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                isFormValid = validateForm();
              });
            },
          ),
        ),
      ],
    );
  }

  bool validateForm() {
    String day = _dayController.text;
    String month = _monthController.text;
    String year = _yearController.text;

    // Realiza aquí la validación personalizada que necesites para los valores ingresados

    return day.isNotEmpty && month.isNotEmpty && year.isNotEmpty;
  }
}

class DropdownDateSelector extends StatefulWidget {
  final List<DateTime> dateItems;

  DropdownDateSelector({required this.dateItems});

  @override
  _DropdownDateSelectorState createState() => _DropdownDateSelectorState();
}

class _DropdownDateSelectorState extends State<DropdownDateSelector> {
  DateTime? selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Selecciona una fecha:',
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 20.0),
        DropdownButton<DateTime>(
          value: selectedDate,
          onChanged: (DateTime? newValue) {
            setState(() {
              selectedDate = newValue;
            });
          },
          items: widget.dateItems.map((DateTime date) {
            return DropdownMenuItem<DateTime>(
              value: date,
              child: Text(
                '${date.day}/${date.month}/${date.year}',
                style: TextStyle(fontSize: 18.0),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20.0),
        Text(
          'Fecha seleccionada: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    );
  }
}

class SettingsDateWidget extends StatefulWidget {
  final List<DateTime> items; // Lista de fechas
  final String? Function(DateTime?) validator;
  final String hint;
  final String? cabecera;
  final Icon? icon;
  final void Function(DateTime) onChanged;
  final DateTime? initialValue;

  const SettingsDateWidget({
    required this.items,
    required this.hint,
    this.cabecera,
    this.icon,
    required this.onChanged,
    required this.validator,
    this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  _SettingsDateWidgetState createState() => _SettingsDateWidgetState();
}

class _SettingsDateWidgetState extends State<SettingsDateWidget> {
  DateTime? _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      initialValue: _currentDate,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.cabecera != null)
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    widget.cabecera!,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<DateTime>(
                  value: _currentDate,
                  hint: Text(widget.hint),
                  items: _buildDropdownMenuItems(),
                  onChanged: (value) {
                    if (widget.validator != null) {
                      state.setValue(value);
                      state.validate();
                    }
                    setState(() {
                      _currentDate = value;
                    });
                    widget.onChanged(value!);
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 0),
                    prefixIcon: widget.icon,
                  ),
                ),
              ),
              if (state.hasError)
                Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 194, 18, 18),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<DateTime>> _buildDropdownMenuItems() {
    return widget.items.map<DropdownMenuItem<DateTime>>((DateTime date) {
      return DropdownMenuItem<DateTime>(
        alignment: Alignment.center,
        value: date,
        child: Text(
          DateFormat('dd/MM/yyyy').format(date), // Formatea la fecha
          style: TextStyle(fontSize: 18.0),
        ),
      );
    }).toList();
  }
}

class Drop extends StatefulWidget {
  final List<DateTime> dateItems; // Agrega un parámetro para las fechas
  final DateTime? initialValue;

  final void Function(DateTime?)
      onChanged; // Agrega un parámetro para el valor inicial
  const Drop(
      {Key? key,
      required this.dateItems,
      this.initialValue,
      required this.onChanged})
      : super(key: key);

  @override
  State<Drop> createState() => _DropState();
}

class _DropState extends State<Drop> {
  DateTime? dropdownValue; // Variable para el valor seleccionado

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue; // Establecer el valor inicial
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromARGB(
            255, 24, 0, 80), // Cambia el color de fondo de selección a azul
      ),
      child: DropdownButton<DateTime>(
        onTap: () {},
        value: dropdownValue,
        items:
            widget.dateItems.map<DropdownMenuItem<DateTime>>((DateTime value) {
          return DropdownMenuItem<DateTime>(
            value: value,
            child: Text(
              DateFormat('dd/MM/yyyy').format(value),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          );
        }).toList(),
        onChanged: (DateTime? newValue) {
          setState(() {
            dropdownValue = newValue;
          });
          widget.onChanged(newValue);
        },
      ),
    );
  }
}
*/