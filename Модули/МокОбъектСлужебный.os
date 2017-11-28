#Использовать asserts

// {Область переменных}

Перем Мок_РежимУстановкиВозвращаемогоЗначенияМетода;
Перем Мок_ВозвращаемыеЗначения;
Перем Мок_УстанавливаемоеВозвращаемоеЗначение;
Перем Мок_РежимПроверкиВызоваМетода;
Перем Мок_ВызываемыеМетоды;

// {Область методов}

Процедура Мок_СохранитьВызовМетода(Знач Мок_СтруктураПараметрыПроцедуры)
	
	// Заполним колонки
	Мок_Колонки = Мок_ВызываемыеМетоды.Колонки;
	Для Каждого Мок_КлючИЗначение Из Мок_СтруктураПараметрыПроцедуры Цикл
		Если Мок_Колонки.Найти(Мок_КлючИЗначение.Ключ) = Неопределено Тогда
			Мок_Колонки.Добавить(Мок_КлючИЗначение.Ключ);
		КонецЕсли;
	КонецЦикла;
	
	// Создадим и сохраним данные для возращаемого значения
	Мок_НайденныеСтроки = Мок_ВызываемыеМетоды.НайтиСтроки(Мок_СтруктураПараметрыПроцедуры);
	Если Мок_НайденныеСтроки.Количество() = 0 Тогда
		Мок_ВызываемыйМетод = Мок_ВызываемыеМетоды.Добавить();
		ЗаполнитьЗначенияСвойств(Мок_ВызываемыйМетод, Мок_СтруктураПараметрыПроцедуры);
	КонецЕсли;
	
КонецПроцедуры

Процедура Мок_НачатьУстанавливатьВозвращаемоеЗначение(Знач Мок_ИмяМетода, Знач Мок_ПараметрыПроцедуры)
	
	// Заполним колонки
	Мок_Колонки = Мок_ВозвращаемыеЗначения.Колонки;
	Для Каждого Мок_КлючИЗначение Из Мок_ПараметрыПроцедуры Цикл
		Если Мок_Колонки.Найти(Мок_КлючИЗначение.Ключ) = Неопределено Тогда
			Мок_Колонки.Добавить(Мок_КлючИЗначение.Ключ);
		КонецЕсли;
	КонецЦикла;

	// Создадим и сохраним данные для возращаемого значения
	Мок_СтруктураПоиска = Новый Структура(Мок_ПараметрыПроцедуры);
	Мок_СтруктураПоиска.Вставить("ИмяМетода", Мок_ИмяМетода);
	Мок_НайденныеСтроки = Мок_ВозвращаемыеЗначения.НайтиСтроки(Мок_СтруктураПоиска);
	Если Мок_НайденныеСтроки.Количество() = 0 Тогда
		Мок_УстанавливаемоеВозвращаемоеЗначение = Мок_ВозвращаемыеЗначения.Добавить();
		ЗаполнитьЗначенияСвойств(Мок_УстанавливаемоеВозвращаемоеЗначение, Мок_СтруктураПоиска);
	Иначе
		Мок_УстанавливаемоеВозвращаемоеЗначение = Мок_НайденныеСтроки[0];
	КонецЕсли;

КонецПроцедуры

Процедура Мок_СохранитьВозвращаемоеЗначение(Знач Мок_ВозвращаемоеЗначение)
	Мок_УстанавливаемоеВозвращаемоеЗначение.Мок_ВозвращаемоеЗначение = Мок_ВозвращаемоеЗначение;
КонецПроцедуры

Функция Мок_НайтиСохраненноеЗначение(Знач Мок_СтруктураПоиска, Знач Мок_КоллекцияСохраненныхЗначений)
	
	Мок_НайденноеСохраненноеЗначение = NULL;

	Для Каждого Мок_Строка_СохраненныеЗначения Из Мок_КоллекцияСохраненныхЗначений Цикл
		
		Мок_СтрокаСовпала = Истина;
		Для Каждого Мок_ПолеПоиска Из Мок_СтруктураПоиска Цикл
			Если НЕ Мок_ОбъектыРавны(Мок_Строка_СохраненныеЗначения[Мок_ПолеПоиска.Ключ], Мок_ПолеПоиска.Значение) Тогда
				Мок_СтрокаСовпала = Ложь;
				Прервать;
			КонецЕсли;
		КонецЦикла;

		Если Мок_СтрокаСовпала Тогда
			Мок_НайденноеСохраненноеЗначение = Мок_Строка_СохраненныеЗначения;
			Прервать;
		КонецЕсли;
	КонецЦикла;

	Возврат Мок_НайденноеСохраненноеЗначение;

КонецФункции

Функция Мок_НайтиСохраненноеВозвращаемоеЗначение(Знач Мок_СтруктураПоиска)
	
	Мок_СохраненноеЗначение = Мок_НайтиСохраненноеЗначение(Мок_СтруктураПоиска, Мок_ВозвращаемыеЗначения);
	Если Мок_СохраненноеЗначение = NULL Тогда
		Возврат NULL;
	Иначе
		Возврат Мок_СохраненноеЗначение.Мок_ВозвращаемоеЗначение;
	КонецЕсли;
	
КонецФункции

Функция Мок_ЭтоМокОбъект(Объект)
	
	Мок_ТипОбъекта = ТипЗнч(Объект);
	Если Мок_ТипОбъекта <> Тип("Сценарий") Тогда
		Возврат Ложь;
	КонецЕсли;

	Мок_Рефлектор = Новый Рефлектор;
	Мок_МетодыОбъекта = Мок_Рефлектор.ПолучитьТаблицуМетодов(Объект);
	
	Возврат 
		Мок_МетодыОбъекта.Найти("Когда", "Имя") <> Неопределено
		И Мок_МетодыОбъекта.Найти("ТогдаВозвращает", "Имя") <> Неопределено;

КонецФункции

Функция Мок_ОбъектыРавны(Знач Мок_Объект1, Знач Мок_Объект2)

	Сообщить("Сравниваю " + Мок_Объект1 + " " + Мок_Объект2);

	Мок_ПримитивныеТипы = Новый Массив;
	Мок_ПримитивныеТипы.Добавить(Тип("Строка"));
	Мок_ПримитивныеТипы.Добавить(Тип("Число"));
	Мок_ПримитивныеТипы.Добавить(Тип("Булево"));
	Мок_ПримитивныеТипы.Добавить(Тип("Дата"));
	Мок_ПримитивныеТипы.Добавить(Тип("Неопределено"));
	Мок_ПримитивныеТипы.Добавить(Тип("NULL"));
	Мок_ПримитивныеТипы.Добавить(Тип("Тип"));

	Мок_ТипЗнч1 = ТипЗнч(Мок_Объект1);
	Мок_ТипЗнч2 = ТипЗнч(Мок_Объект2);
	Мок_ЭтоПримитивныйТип1 = Мок_ПримитивныеТипы.Найти(Мок_ТипЗнч1) <> Неопределено;
	Мок_ЭтоПримитивныйТип2 = Мок_ПримитивныеТипы.Найти(Мок_ТипЗнч2) <> Неопределено;

	Мок_Рефлектор = Новый Рефлектор;
	
	Если НЕ Мок_ЭтоПримитивныйТип1 Тогда
		Сообщить("0");
		Мок_СвойстваОбъекта1 = Мок_Рефлектор.ПолучитьТаблицуСвойств(Мок_Объект1);
		
	КонецЕсли;
	
	Если НЕ Мок_ЭтоПримитивныйТип2 Тогда
		Мок_СвойстваОбъекта2 = Мок_Рефлектор.ПолучитьТаблицуСвойств(Мок_Объект2);
	КонецЕсли;
	
	Если 
		(Мок_ЭтоМокОбъект(Мок_Объект1) И НЕ Мок_ЭтоПримитивныйТип2)
		ИЛИ
		(Мок_ЭтоМокОбъект(Мок_Объект2) И НЕ Мок_ЭтоПримитивныйТип1) Тогда
		
		// Сравниваем объекты далее, т.к. один из них является моком 
	ИначеЕсли Мок_ТипЗнч1 <> Мок_ТипЗнч2 Тогда
		Возврат Ложь;
	ИначеЕсли Мок_ЭтоПримитивныйТип1 И Мок_ЭтоПримитивныйТип2 Тогда
		Возврат Мок_Объект1 = Мок_Объект2;
	ИначеЕсли Мок_ЭтоПримитивныйТип1 Тогда
		Возврат Ложь;
	ИначеЕсли Мок_ЭтоПримитивныйТип2 Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Мок_ЕстьПоддержкаОбходаКоллекции = Истина;
	Попытка
		Для Каждого Мок_Элемент Из Мок_Объект1 Цикл
			Прервать;
		КонецЦикла;
	Исключение
		Мок_ЕстьПоддержкаОбходаКоллекции = Ложь;
	КонецПопытки;

	Если Мок_ЕстьПоддержкаОбходаКоллекции Тогда
		
		Сообщить("Есть поддержка обхода коллекции");

		Мок_ДлинаКоллекции1 = 0;
		Мок_ДлинаКоллекции2 = 0;
		Для Каждого Мок_Элемент Из Мок_Объект1 Цикл
			Мок_ДлинаКоллекции1 = Мок_ДлинаКоллекции1 + 1;
		КонецЦикла;
		Для Каждого Мок_Элемент Из Мок_Объект2 Цикл
			Мок_ДлинаКоллекции2 = Мок_ДлинаКоллекции2 + 1;
		КонецЦикла;

		Если Мок_ДлинаКоллекции1 <> Мок_ДлинаКоллекции2 Тогда
			Сообщить("Длины коллекций не совпадают");
			Возврат Ложь;
		КонецЕсли;

		Если Мок_ДлинаКоллекции1 = 0 Тогда
			Сообщить("Длина коллекции равна нулю");
			Возврат Истина;
		КонецЕсли;

		Мок_СчетчикЭлементовКоллекции1 = 0;
		Для Каждого Мок_ЭлементКоллекции1 Из Мок_Объект1 Цикл
			Мок_СчетчикЭлементовКоллекции1 = Мок_СчетчикЭлементовКоллекции1 + 1;
			Мок_ЭлементКоллекции2 = Неопределено;

			Мок_СчетчикЭлементовКоллекции2 = 1;
			Для Каждого Мок_ЭлементКоллекции2_сч Из Мок_Объект2 Цикл
				Сообщить("счетчик 1: " + Мок_СчетчикЭлементовКоллекции1 + " " + "счетчик 2: " + Мок_СчетчикЭлементовКоллекции2);
				Если Мок_СчетчикЭлементовКоллекции2 = Мок_СчетчикЭлементовКоллекции1 Тогда
					Мок_ЭлементКоллекции2 = Мок_ЭлементКоллекции2_сч;
					Прервать;
				КонецЕсли;
				Мок_СчетчикЭлементовКоллекции2 = Мок_СчетчикЭлементовКоллекции2 + 1;
			КонецЦикла;
			
			Если НЕ Мок_ОбъектыРавны(Мок_ЭлементКоллекции1, Мок_ЭлементКоллекции2) Тогда
				Возврат Ложь;
			КонецЕсли;
		КонецЦикла;
		
		Возврат Истина;
		
	Иначе

		Сообщить("Нет поддержки обхода коллекции");

		Если Мок_СвойстваОбъекта1.Количество() <> Мок_СвойстваОбъекта2.Количество() Тогда
			Сообщить("Количество свойств не совпадает");
			Возврат Ложь;
		КонецЕсли;

		Если Мок_СвойстваОбъекта1.Количество() = 0 Тогда
			Сообщить("Нет свойств");
			Сообщить("Возвращаю истину. ТОЧНО равны? " + Мок_Объект1 + " " + Мок_Объект2);
			Возврат Истина;
		КонецЕсли;

		Сообщить("Мок_СвойстваОбъекта1.Количество " + Мок_СвойстваОбъекта1.Количество());
		Сообщить("Мок_СвойстваОбъекта2.Количество " + Мок_СвойстваОбъекта2.Количество());

		Для Каждого Мок_Свойство1 Из Мок_СвойстваОбъекта1 Цикл
			Мок_ИмяСвойства1 = Мок_Свойство1[0];

			Сообщить("Имя свойства " + Мок_ИмяСвойства1);

			Мок_ИмяСвойстваСуществует = Ложь;
			Для Каждого Мок_Свойство2 Из Мок_СвойстваОбъекта2 Цикл
				Сообщить("Имя свойства2 " + Мок_Свойство2[0]);
				Если Мок_Свойство2[0] = Мок_ИмяСвойства1 Тогда
					Мок_ИмяСвойстваСуществует = Истина;
					Прервать;
				КонецЕсли;
			КонецЦикла;
			
			Если НЕ Мок_ИмяСвойстваСуществует Тогда
				Сообщить("Нет свойства " + Мок_ИмяСвойства1);
				Возврат Ложь;
			КонецЕсли;

			Сообщить("Вычисляю 1");
			Мок_ЗначениеСвойства1 = Вычислить("Мок_Объект1." + Мок_ИмяСвойства1);
			Сообщить("Вычисляю 2");
			Мок_ЗначениеСвойства2 = Вычислить("Мок_Объект2." + Мок_ИмяСвойства1);
			
			Возврат Мок_ОбъектыРавны(Мок_ЗначениеСвойства1, Мок_ЗначениеСвойства2);
		
		КонецЦикла;
	КонецЕсли;

КонецФункции

Функция Когда() Экспорт

	Мок_РежимУстановкиВозвращаемогоЗначенияМетода = Истина;
	Возврат ЭтотОбъект;

КонецФункции

Процедура ТогдаВозвращает(Знач Мок_ВозвращаемоеЗначение) Экспорт

	Мок_РежимУстановкиВозвращаемогоЗначенияМетода = Ложь;
	Мок_СохранитьВозвращаемоеЗначение(Мок_ВозвращаемоеЗначение);

КонецПроцедуры

Функция ПроверитьЧтоВызывалсяМетод() Экспорт
	
	Мок_РежимПроверкиВызоваМетода = Истина;
	Возврат ЭтотОбъект;

КонецФункции

Мок_ВозвращаемыеЗначения = Новый ТаблицаЗначений;
Мок_ВозвращаемыеЗначения.Колонки.Добавить("ИмяМетода");
Мок_ВозвращаемыеЗначения.Колонки.Добавить("Мок_ВозвращаемоеЗначение");

Мок_ВызываемыеМетоды = Новый ТаблицаЗначений;
Мок_ВызываемыеМетоды.Колонки.Добавить("ИмяМетода");

Мок_РежимУстановкиВозвращаемогоЗначенияМетода = Ложь;
Мок_РежимПроверкиВызоваМетода = Ложь;
