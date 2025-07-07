/*
  # Schemat platformy szkoleniowej

  1. Nowe tabele
    - `trainers` - tabela trenerów z informacjami o doświadczeniu i specjalizacjach
    - `trainings` - tabela szkoleń z opisami, cenami i materiałami
    - `training_tests` - testy kompetencji przypisane do szkoleń
    - `test_questions` - pytania testowe z opcjami odpowiedzi
    - `purchases` - zakupy szkoleń przez użytkowników
    - `test_results` - wyniki testów użytkowników
    - `email_leads` - maile zebrane po ukończeniu testów

  2. Bezpieczeństwo
    - Włączenie RLS na wszystkich tabelach
    - Polityki dostępu dla użytkowników i administratorów
    - Zabezpieczenie danych osobowych

  3. Funkcjonalności
    - System prezentacji trenerów i szkoleń
    - Mechanizm zakupów
    - System testów kompetencji
    - Zbieranie leadów mailowych
*/

-- Tabela trenerów
CREATE TABLE IF NOT EXISTS trainers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  bio text NOT NULL,
  specializations text[] DEFAULT '{}',
  experience_years integer DEFAULT 0,
  photo_url text,
  linkedin_url text,
  email text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Tabela szkoleń
CREATE TABLE IF NOT EXISTS trainings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text NOT NULL,
  detailed_description text,
  trainer_id uuid REFERENCES trainers(id) ON DELETE SET NULL,
  price decimal(10,2) NOT NULL DEFAULT 0,
  duration_hours integer DEFAULT 8,
  max_participants integer DEFAULT 20,
  category text NOT NULL DEFAULT 'ogólne',
  difficulty_level text NOT NULL DEFAULT 'początkujący',
  image_url text,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Tabela testów kompetencji
CREATE TABLE IF NOT EXISTS training_tests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  training_id uuid REFERENCES trainings(id) ON DELETE CASCADE,
  title text NOT NULL,
  description text,
  passing_score integer DEFAULT 70,
  time_limit_minutes integer DEFAULT 30,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

-- Tabela pytań testowych
CREATE TABLE IF NOT EXISTS test_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  test_id uuid REFERENCES training_tests(id) ON DELETE CASCADE,
  question text NOT NULL,
  options jsonb NOT NULL DEFAULT '[]',
  correct_answer integer NOT NULL,
  points integer DEFAULT 1,
  created_at timestamptz DEFAULT now()
);

-- Tabela zakupów
CREATE TABLE IF NOT EXISTS purchases (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  training_id uuid REFERENCES trainings(id) ON DELETE CASCADE,
  amount decimal(10,2) NOT NULL,
  status text NOT NULL DEFAULT 'pending',
  payment_method text,
  transaction_id text,
  purchased_at timestamptz DEFAULT now(),
  UNIQUE(user_id, training_id)
);

-- Tabela wyników testów
CREATE TABLE IF NOT EXISTS test_results (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  test_id uuid REFERENCES training_tests(id) ON DELETE CASCADE,
  score integer NOT NULL,
  max_score integer NOT NULL,
  passed boolean NOT NULL DEFAULT false,
  answers jsonb DEFAULT '{}',
  completed_at timestamptz DEFAULT now()
);

-- Tabela leadów mailowych
CREATE TABLE IF NOT EXISTS email_leads (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email text NOT NULL,
  name text,
  test_id uuid REFERENCES training_tests(id) ON DELETE SET NULL,
  training_id uuid REFERENCES trainings(id) ON DELETE SET NULL,
  score integer,
  source text DEFAULT 'test_completion',
  created_at timestamptz DEFAULT now(),
  UNIQUE(email, test_id)
);

-- Włączenie RLS
ALTER TABLE trainers ENABLE ROW LEVEL SECURITY;
ALTER TABLE trainings ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_tests ENABLE ROW LEVEL SECURITY;
ALTER TABLE test_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE purchases ENABLE ROW LEVEL SECURITY;
ALTER TABLE test_results ENABLE ROW LEVEL SECURITY;
ALTER TABLE email_leads ENABLE ROW LEVEL SECURITY;

-- Polityki RLS - publiczny dostęp do odczytu trenerów i szkoleń
CREATE POLICY "Publiczny dostęp do trenerów"
  ON trainers FOR SELECT
  TO anon, authenticated
  USING (true);

CREATE POLICY "Publiczny dostęp do szkoleń"
  ON trainings FOR SELECT
  TO anon, authenticated
  USING (is_active = true);

CREATE POLICY "Publiczny dostęp do testów"
  ON training_tests FOR SELECT
  TO anon, authenticated
  USING (is_active = true);

CREATE POLICY "Publiczny dostęp do pytań testowych"
  ON test_questions FOR SELECT
  TO anon, authenticated
  USING (true);

-- Polityki dla zakupów - tylko własne dane
CREATE POLICY "Użytkownicy widzą własne zakupy"
  ON purchases FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Użytkownicy mogą dodawać zakupy"
  ON purchases FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Polityki dla wyników testów
CREATE POLICY "Użytkownicy widzą własne wyniki"
  ON test_results FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Użytkownicy mogą dodawać wyniki"
  ON test_results FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Polityki dla leadów mailowych - tylko dodawanie
CREATE POLICY "Dodawanie leadów mailowych"
  ON email_leads FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- Indeksy dla wydajności
CREATE INDEX IF NOT EXISTS idx_trainings_trainer_id ON trainings(trainer_id);
CREATE INDEX IF NOT EXISTS idx_trainings_category ON trainings(category);
CREATE INDEX IF NOT EXISTS idx_trainings_active ON trainings(is_active);
CREATE INDEX IF NOT EXISTS idx_test_questions_test_id ON test_questions(test_id);
CREATE INDEX IF NOT EXISTS idx_purchases_user_id ON purchases(user_id);
CREATE INDEX IF NOT EXISTS idx_purchases_training_id ON purchases(training_id);
CREATE INDEX IF NOT EXISTS idx_test_results_user_id ON test_results(user_id);
CREATE INDEX IF NOT EXISTS idx_test_results_test_id ON test_results(test_id);
CREATE INDEX IF NOT EXISTS idx_email_leads_email ON email_leads(email);