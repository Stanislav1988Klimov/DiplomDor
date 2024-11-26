
#Область СлужебныеПроцедурыИФункции

Процедура ВКМ_ОтправкаВТГ() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
|	ВКМ_УведомленияТГБоту.ТекстСообщения,
|	ВКМ_УведомленияТГБоту.Ссылка,
|	ВКМ_ИдентификаторГруппыДляОповещения.Значение КАК Chat_id,
|	ВКМ_ТокенУправленияТелеграмБотом.Значение КАК ТокенТГ
|ИЗ
|	Константа.ВКМ_ТокенУправленияТелеграмБотом КАК ВКМ_ТокенУправленияТелеграмБотом,
|	Константа.ВКМ_ИдентификаторГруппыДляОповещения КАК ВКМ_ИдентификаторГруппыДляОповещения,
|	Справочник.ВКМ_УведомленияТГБоту КАК ВКМ_УведомленияТГБоту";
	
 РезультатЗапроса = Запрос.Выполнить();
   
   Выборка = РезультатЗапроса.Выбрать();
   
   Пока Выборка.Следующий() Цикл
    	Токен = Выборка.ТокенТГ;
    	Chat_id = Выборка.Chat_id;
    	ТекстСообщения = Выборка.ТекстСообщения;
        АдресТГ = "api.telegram.org";	
	
	Соединение = Новый HTTPСоединение(АдресТГ, 443, , , , ,Новый ЗащищенноеСоединениеOpenSSL( ));

		АдресЗапроса = "bot" 
                + Токен 
                + "/sendMessage"
                + "?chat_id=" 
                + Chat_id
                + "&text=" 
                + ТекстСообщения;
		ЗапросHTTP = Новый HTTPЗапрос(АдресЗапроса);
				
   Попытка
   		Результат = Соединение.ОтправитьДляОбработки(ЗапросHTTP);
   		Объект = Выборка.Ссылка.ПолучитьОбъект();
   		Объект.Удалить(); 	
   Исключение
   		ЗаписьЖурналаРегистрации(НСтр("ru = 'Выполнение операции'"),
   		УровеньЖурналаРегистрации.Ошибка,,,
   		ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
   КонецПопытки;     
   
   		Если Не Результат.КодСостояния = 200 Тогда
   			ВызватьИсключение "Ошибка проверка связи";
   		КонецЕсли;
   		
   		
   			
   			Возврат;
   
    КонецЦикла;
	
КонецПроцедуры

#КонецОбласти





