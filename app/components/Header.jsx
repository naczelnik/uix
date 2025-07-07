import { Link } from "@remix-run/react";

export default function Header() {
  return (
    <header className="bg-white shadow-sm border-b border-gray-200">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          <div className="flex items-center">
            <Link to="/" className="flex items-center space-x-2">
              <div className="w-8 h-8 bg-primary-600 rounded-lg flex items-center justify-center">
                <span className="text-white font-bold text-sm">AR</span>
              </div>
              <span className="text-xl font-bold text-gray-900">Akademia Rozwoju</span>
            </Link>
          </div>
          
          <nav className="hidden md:flex space-x-8">
            <Link to="/" className="text-gray-700 hover:text-primary-600 font-medium transition-colors">
              Strona główna
            </Link>
            <Link to="/szkolenia" className="text-gray-700 hover:text-primary-600 font-medium transition-colors">
              Szkolenia
            </Link>
            <Link to="/trenerzy" className="text-gray-700 hover:text-primary-600 font-medium transition-colors">
              Trenerzy
            </Link>
            <Link to="/testy" className="text-gray-700 hover:text-primary-600 font-medium transition-colors">
              Testy kompetencji
            </Link>
          </nav>
          
          <div className="flex items-center space-x-4">
            <Link to="/logowanie" className="text-gray-700 hover:text-primary-600 font-medium transition-colors">
              Logowanie
            </Link>
            <Link to="/rejestracja" className="btn-primary">
              Rejestracja
            </Link>
          </div>
        </div>
      </div>
    </header>
  );
}
