---

[cite_start]**Факултет Компютърни Системи и Технологии** [cite: 1]
[cite_start]**Катедра „Компютърни системи"** [cite: 1]
[cite_start]**ЦОИ, Бакалавърска програма** [cite: 2]

---

## [cite_start]Тема 5: Морфологични операции с изображения [cite: 3]

### [cite_start]1. Морфологични оператори [cite: 4]
[cite_start]Морфологичните оператори имат за задача да преобразуват първоначалното изображение чрез взаимодействие с друго изображение-маска с определена форма и размери, наречено **структурен елемент**[cite: 5]. [cite_start]Геометричните особености на оригиналното изображение, които са подобни на структурния елемент, се запазват в обработения резултат[cite: 6].

[cite_start]Изборът на размер и форма на структурните елементи позволява създаването на оператори, които са чувствителни към специфичната структура и форма на обектите в анализираното изображение[cite: 7].

### [cite_start]2. Структурен елемент [cite: 9]
[cite_start]Най-често използваният структурен елемент при обработката на бинарни и полутонови изображения е квадратна матрица с размерност $3 \times 3$ със стойности 1[cite: 8].

#### [cite_start]Създаване в Matlab [cite: 22]
Използваната функция за създаване на структурни елементи е:
[cite_start]`SE = strel (shape, parameters)` [cite: 23]

Където `shape` задава формата. Възможните стойности за плоски елементи включват:
* [cite_start]`'arbitrary'` [cite: 24]
* [cite_start]`'diamond'` [cite: 24]
* [cite_start]`'disk'` [cite: 24]
* [cite_start]`'line'` [cite: 24]
* [cite_start]`'octagon'` [cite: 24]
* [cite_start]`'pair'` [cite: 24]
* [cite_start]`'periodicline'` [cite: 24]
* [cite_start]`'rectangle'` [cite: 24]
* [cite_start]`'square'` [cite: 24]
* [cite_start]Изпъкнали елементи: `'arbitrary'` и `'ball'`[cite: 24].

---

### [cite_start]3. Основни морфологични операции [cite: 30]
[cite_start]Прилагането на тези операции води до промяна на цялостния размер и форма на групи пиксели[cite: 31]. Те се използват за:
* [cite_start]Разширяване или свиване на елементи[cite: 31].
* [cite_start]Изглаждане на граници[cite: 31].
* [cite_start]Откриване на външни и вътрешни граници[cite: 31].
* [cite_start]Извличане на прости геометрични форми за идентификация[cite: 31].

#### [cite_start]Дилатация (Dilatation) [cite: 32]
[cite_start]Операция, която добавя пиксели към границите на обектите[cite: 33]. [cite_start]Броят на добавените пиксели зависи от размера и формата на структурния елемент[cite: 34].
* [cite_start]**Matlab функция:** `$IM2 = imdilate (IM, SE)$` [cite: 46]

#### [cite_start]Ерозия (Erosion) [cite: 35]
[cite_start]Премахва изолирани пиксели от фона и „разрушава“ (ерозира) контурите на обектите в съответствие с вида на структурния елемент[cite: 36].
* [cite_start]**Matlab функция:** `$IM2 = imerode (IM, SE)$` [cite: 47, 48]

#### [cite_start]Отваряне (Opening) [cite: 50]
[cite_start]Съчетава операциите **ерозия** и **дилатация**, използващи един и същ структурен елемент[cite: 51]. [cite_start]Операцията не променя значително площта на големите обекти, но малки обекти, отстранени при ерозията, не се възстановяват[cite: 52, 53].
* [cite_start]**Matlab функция:** `$IM2 = imopen (IM, SE)$` [cite: 59]

#### [cite_start]Затваряне (Closing) [cite: 54]
[cite_start]Съчетава операциите **дилатация** и **ерозия** с един и същ структурен елемент[cite: 55]. [cite_start]Границите, разширени при дилатацията, се свиват обратно, но малки празнини, запълнени по време на дилатацията, не се възстановяват[cite: 56, 57].
* [cite_start]**Matlab функция:** `$IM2 = imclose (IM, SE)$` [cite: 60]

---

### [cite_start]4. Попадение-пропуск (Hit-Miss) [cite: 70]
[cite_start]Тази операция е предназначена да локализира специфични конфигурации от пиксели[cite: 71]. Може да се използва за откриване на:
* [cite_start]Изолирани пиксели[cite: 71].
* [cite_start]Кръстосани (cross-shape) или надлъжни фигури[cite: 71].
* [cite_start]Прави ъгли по границите на обектите[cite: 71].

[cite_start]Колкото по-голям е структурният елемент, толкова по-специфичен е изследваният шаблон[cite: 72].

#### [cite_start]Реализация в Matlab [cite: 73]
[cite_start]`BW2 = bwhitmiss(BW1, SE1, SE2)` [cite: 74]
* [cite_start]**BW1:** Двоично изображение[cite: 75].
* **SE1 и SE2:** Плоски структурни елементи. [cite_start]Операцията запазва пиксели, чиито съседи съответстват на `SE1` и не съответстват на `SE2`[cite: 75].

---
[cite_start]*Материалът е изготвен от д-р Ива Николова и д-р Георги Запрянов (2025/2026).* [cite: 25, 76]

<div class="no-overflow"><p style="text-align: center;"><strong>Морфологични операции и сегментация на изображения</strong></p>
<!-- Card 1 -->
<div style="background: #ffffff; border: 1px solid #e5e7eb; border-left: 7px solid #6366f1; border-radius: 14px; padding: 14px 16px; box-shadow: 0 8px 16px rgba(0,0,0,0.06);">
<div style="display: flex; align-items: center; gap: 10px;">
<div style="padding: 6px 10px; border-radius: 10px; background: #e0e7ff; color: #3730a3; display: inline-flex; align-items: center; justify-content: center; font-weight: 800; white-space: nowrap;">Задание 1</div>
<div style="font-size: 16px; font-weight: 800; color: #0f172a; line-height: 1.25;">Дилатация и влияние на формата на структурния елемент</div>
</div>
<div style="margin-top: 6px; font-size: 13px; color: #334155;"><strong>Цел:</strong> Да се изследва как формата на структурния елемент (SE) влияе върху „нарастването“ на обектите при дилатация и върху свързването/запълването на детайли.</div>
<div style="margin-top: 10px; background: #eef2ff; border: 1px solid #c7d2fe; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #0f172a; margin-bottom: 6px;">Експеримент</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Прочетете изображенията <strong>Dilation.tif</strong> и <strong>ToiletOpen.tif</strong>.</li>
<li>Приложете <strong>дилатация</strong> чрез <strong>imdilate</strong> със структурния елемент, даден в условието или предоставен в примерния код (оригинален SE).</li>
<li>Покажете матрицата или визуализацията на оригиналния SE.</li>
<li>Променете структурния елемент така, че единици да има само по главния и второстепенния диагонал (SE тип „X“).</li>
<li>Повторете дилатацията с новия SE и подгответе визуално сравнение (преди/след) за двете изображения.</li>
</ul>
</div>
<div style="margin-top: 10px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
<div style="background: #fff1f2; border: 1px solid #fecdd3; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #991b1b; margin-bottom: 6px;">Анализ</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Сравнете резултатите за оригиналния SE и за SE тип „X“: кои структури се усилват (осови/диагонални), кои отвори се запълват и кои остават.</li>
<li>Посочете един конкретен детайл (отвор/контур/линия), който се изменя различно при двата SE и обяснете причината.</li>
<li>Опишете качествено ефекта върху: (1) тънки линии, (2) малки празнини, (3) близко разположени обекти.</li>
</ul>
</div>
<div style="background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #166534; margin-bottom: 6px;">Очаквани резултати от изпълнението</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>За всяко изображение: оригинал + резултат с оригинален SE + резултат със SE тип „X“.</li>
<li>Показана матрица/визуализация на двата структурни елемента.</li>
<li>Кратко сравнение (6–10 изречения) с конкретен пример за различие.</li>
</ul>
</div>
</div>
</div>
<div style="height: 12px;">&nbsp;</div>
<!-- Card 2 -->
<div style="background: #ffffff; border: 1px solid #e5e7eb; border-left: 7px solid #f97316; border-radius: 14px; padding: 14px 16px; box-shadow: 0 8px 16px rgba(0,0,0,0.06);">
<div style="display: flex; align-items: center; gap: 10px;">
<div style="padding: 6px 10px; border-radius: 10px; background: #ffedd5; color: #9a3412; display: inline-flex; align-items: center; justify-content: center; font-weight: 800; white-space: nowrap;">Задание 2</div>
<div style="font-size: 16px; font-weight: 800; color: #0f172a; line-height: 1.25;">Ерозия със strel: diamond, disk и square (параметрични експерименти)</div>
</div>
<div style="margin-top: 6px; font-size: 13px; color: #334155;"><strong>Цел:</strong> Да се оцени влиянието на формата и размера на структурния елемент върху ерозията и върху запазването/разрушаването на тънки детайли.</div>
<div style="margin-top: 10px; background: #fff7ed; border: 1px solid #fed7aa; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #0f172a; margin-bottom: 6px;">Експеримент</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Прочетете изображението <strong>Erosion.tif</strong>.</li>
<li>Създайте структурни елементи чрез <strong>strel</strong>: <strong>'diamond'</strong>, <strong>'disk'</strong>, <strong>'square'</strong>.</li>
<li>Използвайте параметрите на <strong>strel</strong>, както следва: за <strong>diamond</strong> – <strong>D</strong>, за <strong>disk</strong> – <strong>R</strong>, за <strong>square</strong> – <strong>W</strong>.</li>
<li>Приложете <strong>ерозия</strong> чрез <strong>imerode</strong> за параметри: <strong>D, R, W = 2, 4, 6, 8, 10</strong> (според типа SE).</li>
<li>Организирайте резултатите така, че ясно да се вижда тенденцията при увеличаване на параметъра (напр. subplot/montage по стойности).</li>
</ul>
</div>
<div style="margin-top: 10px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
<div style="background: #fff1f2; border: 1px solid #fecdd3; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #991b1b; margin-bottom: 6px;">Анализ</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>За всеки тип SE посочете при коя стойност (2/4/6/8/10) започват да изчезват<strong> тънки структури.</strong></li>
<li>Сравнете как disk влияе на закръглени контури спрямо square (ъглови деформации) и diamond (диагонален „характер“).</li>
<li>Направете извод: кой SE е „най-агресивен“ за вашето изображение и защо.</li>
</ul>
</div>
<div style="background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #166534; margin-bottom: 6px;">Очаквани резултати от изпълнението</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Серия резултати за трите типа SE и параметри 2…10 (ясно подредени).</li>
<li>Кратък анализ (8–12 изречения) с конкретни наблюдения за детайли, които изчезват/се запазват.</li>
<li>Обобщение: зависимост „параметър → ерозия“ и разлики между формите.</li>
</ul>
</div>
</div>
</div>
<div style="height: 12px;">&nbsp;</div>
<!-- Card 3 -->
<div style="background: #ffffff; border: 1px solid #e5e7eb; border-left: 7px solid #10b981; border-radius: 14px; padding: 14px 16px; box-shadow: 0 8px 16px rgba(0,0,0,0.06);">
<div style="display: flex; align-items: center; gap: 10px;">
<div style="padding: 6px 10px; border-radius: 10px; background: #d1fae5; color: #065f46; display: inline-flex; align-items: center; justify-content: center; font-weight: 800; white-space: nowrap;">Задание 3</div>
<div style="font-size: 16px; font-weight: 800; color: #0f172a; line-height: 1.25;">HSV сегментация на „язовир“ и извличане на контури чрез XOR</div>
</div>
<div style="margin-top: 6px; font-size: 13px; color: #334155;"><strong>Цел:</strong> Да се приложи сегментация в HSV пространство чрез праг по H и S и да се използват морфологични операции за получаване на чиста маска и контури.</div>
<div style="margin-top: 10px; background: #ecfeff; border: 1px solid #a5f3fc; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #0f172a; margin-bottom: 6px;">Експеримент</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Прочетете <strong>Satellite1.tif</strong> и <strong>Satellite2.tif</strong>.</li>
<li>Конвертирайте от <strong>RGB → HSV</strong> чрез <strong>rgb2hsv</strong> и визуализирайте каналите <strong>H</strong> и <strong>S</strong>.</li>
<li>Определете праг(ове) за H и S за отделяне на „язовир“ (или водна площ) на база преобладаващи стойности в избрана област, чрез анализ на ROI и /или визуализация на стойностите в каналите.</li>
<li>Приложете морфологична операция върху маската чрез <strong>imdilate</strong>, <strong>imerode</strong>, <strong>imopen</strong> и/или <strong>imclose</strong>, според избрания подход.</li>
<li>Изчислете контури чрез <strong>XOR</strong> между маската след прага и маската след морфология.</li>
<li>XOR подчертава пикселите, в които двете маски се различават, и по този начин извежда променените гранични области.</li>
</ul>
</div>
<div style="margin-top: 10px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
<div style="background: #fff1f2; border: 1px solid #fecdd3; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #991b1b; margin-bottom: 6px;">Анализ</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Запишете числовите интервали (H_min…H_max, S_min…S_max), използвани за всяко изображение.</li>
<li>Сравнете Satellite1 vs Satellite2: кои фактори (осветеност, фон, наситеност) налагат различни прагове.</li>
<li>Обяснете ролята на морфологията: кои шумове/дупки премахва и как влияе на границата на обекта.</li>
<li>Оценете контурите от XOR: къде са точни и къде се появяват паразитни граници.</li>
</ul>
</div>
<div style="background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #166534; margin-bottom: 6px;">Очаквани резултати от изпълнението</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>За всяко изображение: RGB + H + S + маска след праг + маска след морфология + контур (XOR).</li>
<li>Таблица/списък с прагове по H и S за Satellite1 и Satellite2.</li>
<li>Кратък анализ (8–12 изречения) за причините за избора на прагове и използваната морфологична операция/SE.</li>
</ul>
</div>
</div>
</div>
<div style="height: 12px;">&nbsp;</div>
<!-- Card 4 -->
<div style="background: #ffffff; border: 1px solid #e5e7eb; border-left: 7px solid #ef4444; border-radius: 14px; padding: 14px 16px; box-shadow: 0 8px 16px rgba(0,0,0,0.06);">
<div style="display: flex; align-items: center; gap: 10px;">
<div style="padding: 6px 10px; border-radius: 10px; background: #fee2e2; color: #991b1b; display: inline-flex; align-items: center; justify-content: center; font-weight: 800; white-space: nowrap;">Задание 4</div>
<div style="font-size: 16px; font-weight: 800; color: #0f172a; line-height: 1.25;">Отваряне и затваряне за почистване и възстановяване (Fingerprint)</div>
</div>
<div style="margin-top: 6px; font-size: 13px; color: #334155;"><strong>Цел:</strong> Да се приложат операции <strong>opening</strong> и <strong>closing</strong> за премахване на шум и възстановяване на прекъсвания, и да се анализира компромисът между „почистване“ и загуба на детайли.</div>
<div style="margin-top: 10px; background: #fef2f2; border: 1px solid #fecaca; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #0f172a; margin-bottom: 6px;">Експеримент</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Прочетете <strong>FingerprintNoise.tif</strong>.</li>
<li>Приложете <strong>opening</strong> чрез <strong>imopen</strong> със структурен елемент <strong>strel('square', W)</strong> за премахване на шум.</li>
<li>След това приложете <strong>closing</strong> чрез <strong>imclose</strong> за възстановяване на липсващи участъци/дефекти.</li>
<li>Повторете експеримента с <strong>поне две стойности</strong> на размера W на square (напр. 3 и 7, или еквивалентни).</li>
</ul>
</div>
<div style="margin-top: 10px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
<div style="background: #fff1f2; border: 1px solid #fecdd3; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #991b1b; margin-bottom: 6px;">Анализ</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Сравнете ефекта при двата размера W: кога шумът намалява, но гребените започват да се сливат/замазват.</li>
<li>Опишете конкретно как closing възстановява прекъсвания, но може да „препълни“ тесни пролуки.</li>
<li>Посочете „най-добра“ стойност W според ваш критерий (визуално качество + запазени детайли).</li>
</ul>
</div>
<div style="background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #166534; margin-bottom: 6px;">Очаквани резултати от изпълнението</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Оригинал + резултат след opening + резултат след closing.</li>
<li>Две серии резултати за различни W и кратък сравнителен коментар.</li>
<li>Извод за компромиса между премахване на шум и загуба на детайли.</li>
</ul>
</div>
</div>
</div>
<div style="height: 12px;">&nbsp;</div>
<!-- Card 5 (Bonus) -->
<div style="background: #ffffff; border: 1px solid #e5e7eb; border-left: 7px solid #f59e0b; border-radius: 14px; padding: 14px 16px; box-shadow: 0 8px 16px rgba(0,0,0,0.06);">
<div style="display: flex; align-items: center; gap: 10px;">
<div style="padding: 6px 10px; border-radius: 10px; background: #fef3c7; color: #92400e; display: inline-flex; align-items: center; justify-content: center; font-weight: 800; white-space: nowrap;">Бонус</div>
<div style="font-size: 16px; font-weight: 800; color: #0f172a; line-height: 1.25;">Разпознаване на цифри в бинарни изображения (образци + морфология)</div>
</div>
<div style="margin-top: 6px; font-size: 13px; color: #334155;"><strong>Цел:</strong> Да се реализира устойчиво разпознаване на цифри чрез сегментация на компоненти, подходяща морфологична предобработка и сравнение с подготвени образци.</div>
<div style="margin-top: 10px; background: #fffbeb; border: 1px solid #fde68a; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #0f172a; margin-bottom: 6px;">Експеримент</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Прочетете бинарните изображения <strong>Digits_Test1.bmp</strong>, <strong>Digits_Test2.bmp</strong>, <strong>Digits_Test3.bmp</strong>.</li>
<li>Подгответе предварително по едно <strong>изображение-образец</strong> за всяка търсена цифра (template).</li>
<li>Предложете и приложете морфологични операции за предобработка (напр. opening/closing, изтъняване/удебеляване, нормализиране на размер).</li>
<li>Сегментирайте цифрите като отделни свързани компоненти и ги сравнете с образците.</li>
<li>За сравнение може да използвате проста мярка за сходство след нормализиране на размера, например брой съвпадащи пиксели.</li>
<li>Изведете резултат: разпознати цифри (и/или позиции/ред на срещане).</li>
</ul>
</div>
<div style="margin-top: 10px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
<div style="background: #fff1f2; border: 1px solid #fecdd3; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #991b1b; margin-bottom: 6px;">Анализ</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Опишете избраната предобработка и как стабилизира формата (шум, дебелина на линиите, запълване на дупки).</li>
<li>Посочете поне един проблемен случай (напр. 8 vs 0, 1 vs 7) и как го разграничавате.</li>
<li>Оценете ограничението на подхода: кога template-based разпознаването може да даде грешка.</li>
</ul>
</div>
<div style="background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 12px; padding: 10px 12px;">
<div style="font-weight: bold; color: #166534; margin-bottom: 6px;">Очаквани резултати от изпълнението</div>
<ul style="margin: 0 0 0 18px; padding: 0; color: #0f172a;">
<li>Демонстрация на сегментация на цифрите (компоненти/рамки) и крайно разпознаване за 3-те тестови изображения.</li>
<li>Кратко описание на шаблоните (templates) и предобработката.</li>
<li>Изведен резултат: списък/низ от разпознатите цифри + кратък анализ на грешка/нееднозначност.</li>
</ul>
</div>
</div>
</div>
<div style="height: 12px;">&nbsp;</div></div>