/*
  # Przykładowe dane dla platformy szkoleniowej

  1. Dane przykładowe
    - Trenerzy z różnymi specjalizacjami
    - Szkolenia z różnych kategorii
    - Testy kompetencji z pytaniami
    - Przykładowe dane demonstracyjne

  2. Kategorie szkoleń
    - Zarządzanie projektami
    - Rozwój osobisty
    - Technologie IT
    - Sprzedaż i marketing
*/

-- Dodanie przykładowych trenerów
INSERT INTO trainers (name, bio, specializations, experience_years, photo_url, linkedin_url, email) VALUES
(
  'Anna Kowalska',
  'Ekspert w dziedzinie zarządzania projektami z 15-letnim doświadczeniem. Certyfikowany PMP i Agile Coach. Prowadzi szkolenia dla największych firm w Polsce.',
  ARRAY['Zarządzanie projektami', 'Agile', 'Scrum', 'Leadership'],
  15,
  'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=400',
  'https://linkedin.com/in/anna-kowalska',
  'anna.kowalska@example.com'
),
(
  'Marcin Nowak',
  'Specjalista od rozwoju osobistego i komunikacji interpersonalnej. Psycholog biznesu z 12-letnim doświadczeniem w coachingu kadry menedżerskiej.',
  ARRAY['Rozwój osobisty', 'Komunikacja', 'Coaching', 'Motywacja'],
  12,
  'https://images.pexels.com/photos/2182970/pexels-photo-2182970.jpeg?auto=compress&cs=tinysrgb&w=400',
  'https://linkedin.com/in/marcin-nowak',
  'marcin.nowak@example.com'
),
(
  'Katarzyna Wiśniewska',
  'Ekspert w dziedzinie technologii IT i transformacji cyfrowej. Były CTO w kilku startupach, obecnie konsultant i trener technologiczny.',
  ARRAY['Technologie IT', 'Transformacja cyfrowa', 'Cloud Computing', 'DevOps'],
  10,
  'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg?auto=compress&cs=tinysrgb&w=400',
  'https://linkedin.com/in/katarzyna-wisniewska',
  'katarzyna.wisniewska@example.com'
),
(
  'Tomasz Zieliński',
  'Specjalista od sprzedaży i marketingu cyfrowego. 8 lat doświadczenia w budowaniu strategii sprzedażowych dla firm B2B i B2C.',
  ARRAY['Sprzedaż', 'Marketing cyfrowy', 'Negocjacje', 'CRM'],
  8,
  'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=400',
  'https://linkedin.com/in/tomasz-zielinski',
  'tomasz.zielinski@example.com'
);

-- Dodanie przykładowych szkoleń
INSERT INTO trainings (title, description, detailed_description, trainer_id, price, duration_hours, max_participants, category, difficulty_level, image_url) VALUES
(
  'Zarządzanie projektami - od podstaw do eksperta',
  'Kompleksowe szkolenie z zarządzania projektami obejmujące metodyki tradycyjne i zwinne.',
  'Podczas tego intensywnego szkolenia poznasz wszystkie aspekty zarządzania projektami. Omówimy metodyki tradycyjne (Waterfall) oraz zwinne (Agile, Scrum). Nauczysz się planować projekty, zarządzać zespołem, kontrolować budżet i terminowość realizacji. Szkolenie zawiera praktyczne ćwiczenia i studia przypadków z prawdziwych projektów.',
  (SELECT id FROM trainers WHERE name = 'Anna Kowalska'),
  1299.00,
  16,
  15,
  'Zarządzanie projektami',
  'średniozaawansowany',
  'https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg?auto=compress&cs=tinysrgb&w=800'
),
(
  'Efektywna komunikacja w zespole',
  'Szkolenie z komunikacji interpersonalnej i budowania relacji w środowisku pracy.',
  'Naucz się skutecznie komunikować w zespole, rozwiązywać konflikty i budować pozytywne relacje. Szkolenie obejmuje techniki aktywnego słuchania, asertywności, komunikacji niewerbalnej oraz zarządzania trudnymi rozmowami. Praktyczne ćwiczenia pomogą Ci zastosować nowe umiejętności w codziennej pracy.',
  (SELECT id FROM trainers WHERE name = 'Marcin Nowak'),
  899.00,
  8,
  20,
  'Rozwój osobisty',
  'początkujący',
  'https://images.pexels.com/photos/3184338/pexels-photo-3184338.jpeg?auto=compress&cs=tinysrgb&w=800'
),
(
  'Wprowadzenie do Cloud Computing',
  'Podstawy chmury obliczeniowej i najważniejsze usługi AWS, Azure i Google Cloud.',
  'Kompleksowe wprowadzenie do świata chmury obliczeniowej. Poznasz głównych dostawców usług chmurowych, ich ofertę i możliwości. Nauczysz się projektować architektury chmurowe, zarządzać kosztami i zapewniać bezpieczeństwo. Szkolenie zawiera praktyczne laboratoria z konfiguracją usług w chmurze.',
  (SELECT id FROM trainers WHERE name = 'Katarzyna Wiśniewska'),
  1599.00,
  12,
  12,
  'Technologie IT',
  'średniozaawansowany',
  'https://images.pexels.com/photos/1181677/pexels-photo-1181677.jpeg?auto=compress&cs=tinysrgb&w=800'
),
(
  'Techniki sprzedaży B2B',
  'Nowoczesne techniki sprzedaży dla firm działających na rynku B2B.',
  'Poznaj skuteczne techniki sprzedaży dedykowane rynkowi B2B. Nauczysz się identyfikować potrzeby klientów biznesowych, budować propozycje wartości, prowadzić negocjacje i zamykać transakcje. Szkolenie obejmuje również wykorzystanie CRM-ów i automatyzację procesów sprzedażowych.',
  (SELECT id FROM trainers WHERE name = 'Tomasz Zieliński'),
  1199.00,
  10,
  18,
  'Sprzedaż i marketing',
  'średniozaawansowany',
  'https://images.pexels.com/photos/3184465/pexels-photo-3184465.jpeg?auto=compress&cs=tinysrgb&w=800'
),
(
  'Leadership i motywowanie zespołu',
  'Rozwijanie umiejętności przywódczych i technik motywowania pracowników.',
  'Szkolenie dla obecnych i przyszłych liderów. Poznasz różne style przywództwa, nauczysz się motywować zespół, delegować zadania i budować zaangażowanie. Omówimy również zarządzanie zmianą, rozwiązywanie konfliktów i budowanie kultury organizacyjnej.',
  (SELECT id FROM trainers WHERE name = 'Marcin Nowak'),
  1399.00,
  14,
  16,
  'Rozwój osobisty',
  'zaawansowany',
  'https://images.pexels.com/photos/3184360/pexels-photo-3184360.jpeg?auto=compress&cs=tinysrgb&w=800'
);

-- Dodanie testów kompetencji
INSERT INTO training_tests (training_id, title, description, passing_score, time_limit_minutes) VALUES
(
  (SELECT id FROM trainings WHERE title = 'Zarządzanie projektami - od podstaw do eksperta'),
  'Test kompetencji - Zarządzanie projektami',
  'Test sprawdzający wiedzę z zakresu zarządzania projektami, metodyk Agile i Scrum.',
  70,
  45
),
(
  (SELECT id FROM trainings WHERE title = 'Efektywna komunikacja w zespole'),
  'Test kompetencji - Komunikacja interpersonalna',
  'Test oceniający umiejętności komunikacyjne i znajomość technik budowania relacji.',
  65,
  30
),
(
  (SELECT id FROM trainings WHERE title = 'Wprowadzenie do Cloud Computing'),
  'Test kompetencji - Cloud Computing',
  'Test sprawdzający podstawową wiedzę o usługach chmurowych i architekturach.',
  75,
  40
),
(
  (SELECT id FROM trainings WHERE title = 'Techniki sprzedaży B2B'),
  'Test kompetencji - Sprzedaż B2B',
  'Test oceniający znajomość technik sprzedaży i procesów negocjacyjnych.',
  70,
  35
);

-- Dodanie przykładowych pytań testowych
INSERT INTO test_questions (test_id, question, options, correct_answer, points) VALUES
-- Pytania dla testu zarządzania projektami
(
  (SELECT id FROM training_tests WHERE title = 'Test kompetencji - Zarządzanie projektami'),
  'Która z metodyk jest przykładem podejścia zwinnego (Agile)?',
  '["Waterfall", "Scrum", "PRINCE2", "PMBOK"]',
  1,
  2
),
(
  (SELECT id FROM training_tests WHERE title = 'Test kompetencji - Zarządzanie projektami'),
  'Co oznacza skrót MVP w kontekście zarządzania projektami?',
  '["Most Valuable Player", "Minimum Viable Product", "Maximum Value Proposition", "Major Version Point"]',
  1,
  2
),
(
  (SELECT id FROM training_tests WHERE title = 'Test kompetencji - Zarządzanie projektami'),
  'Ile trwa typowy Sprint w metodyce Scrum?',
  '["1 tydzień", "2-4 tygodnie", "1 miesiąc", "6 tygodni"]',
  1,
  1
),

-- Pytania dla testu komunikacji
(
  (SELECT id FROM training_tests WHERE title = 'Test kompetencji - Komunikacja interpersonalna'),
  'Co to jest aktywne słuchanie?',
  '["Słuchanie muzyki podczas pracy", "Pełne skupienie na rozmówcy i jego komunikatach", "Głośne wyrażanie swojej opinii", "Przerywanie rozmówcy"]',
  1,
  2
),
(
  (SELECT id FROM training_tests WHERE title = 'Test kompetencji - Komunikacja interpersonalna'),
  'Która postawa jest najbardziej asertywna?',
  '["Agresywna", "Pasywna", "Pewna siebie i szanująca innych", "Manipulacyjna"]',
  2,
  2
),

-- Pytania dla testu Cloud Computing
(
  (SELECT id FROM training_tests WHERE title = 'Test kompetencji - Cloud Computing'),
  'Co oznacza skrót IaaS?',
  '["Internet as a Service", "Infrastructure as a Service", "Information as a Service", "Integration as a Service"]',
  1,
  2
),
(
  (SELECT id FROM training_tests WHERE title = 'Test kompetencji - Cloud Computing'),
  'Który z modeli chmury oferuje największą kontrolę nad infrastrukturą?',
  '["SaaS", "PaaS", "IaaS", "FaaS"]',
  2,
  2
),

-- Pytania dla testu sprzedaży B2B
(
  (SELECT id FROM training_tests WHERE title = 'Test kompetencji - Sprzedaż B2B'),
  'Co to jest BANT w kwalifikacji leadów?',
  '["Budget, Authority, Need, Timeline", "Business, Analysis, Negotiation, Trust", "Buyer, Agent, Network, Target", "Brand, Audience, Niche, Territory"]',
  0,
  2
),
(
  (SELECT id FROM training_tests WHERE title = 'Test kompetencji - Sprzedaż B2B'),
  'Która faza procesu sprzedaży jest najważniejsza?',
  '["Prezentacja produktu", "Zamknięcie transakcji", "Rozpoznanie potrzeb klienta", "Negocjacje cenowe"]',
  2,
  2
);
