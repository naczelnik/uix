import { json } from "@remix-run/node";
import { useLoaderData, Link } from "@remix-run/react";
import { supabase } from "~/lib/supabase";
import Header from "~/components/Header";
import Footer from "~/components/Footer";

export const loader = async () => {
  const { data: trainings } = await supabase
    .from('trainings')
    .select(`
      *,
      trainers (
        name,
        photo_url
      )
    `)
    .eq('is_active', true)
    .limit(6);

  const { data: trainers } = await supabase
    .from('trainers')
    .select('*')
    .limit(4);

  return json({ trainings: trainings || [], trainers: trainers || [] });
};

export default function Index() {
  const { trainings, trainers } = useLoaderData();

  return (
    <div className="min-h-screen">
      <Header />
      
      {/* Hero Section */}
      <section className="bg-gradient-to-br from-primary-600 via-primary-700 to-primary-800 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div>
              <h1 className="text-4xl lg:text-6xl font-bold mb-6 leading-tight">
                Rozwijaj swoje <span className="text-accent-300">kompetencje</span> z najlepszymi
              </h1>
              <p className="text-xl text-primary-100 mb-8 leading-relaxed">
                Profesjonalne szkolenia biznesowe z testami kompetencji. 
                Zdobądź nowe umiejętności i certyfikaty od ekspertów branżowych.
              </p>
              <div className="flex flex-col sm:flex-row gap-4">
                <Link to="/szkolenia" className="btn-primary bg-white text-primary-600 hover:bg-gray-100">
                  Przeglądaj szkolenia
                </Link>
                <Link to="/testy" className="btn-secondary border-primary-300 text-white hover:bg-primary-600">
                  Sprawdź swoje kompetencje
                </Link>
              </div>
            </div>
            <div className="relative">
              <img 
                src="https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg?auto=compress&cs=tinysrgb&w=800" 
                alt="Profesjonalne szkolenia"
                className="rounded-2xl shadow-2xl"
              />
              <div className="absolute -bottom-6 -left-6 bg-accent-500 text-white p-6 rounded-xl shadow-lg">
                <div className="text-3xl font-bold">500+</div>
                <div className="text-accent-100">Zadowolonych uczestników</div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Featured Trainings */}
      <section className="py-20 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl lg:text-4xl font-bold text-gray-900 mb-4">
              Popularne szkolenia
            </h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              Wybierz spośród naszych najchętniej wybieranych szkoleń prowadzonych przez ekspertów
            </p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {trainings.map((training) => (
              <div key={training.id} className="card card-hover">
                <div className="aspect-w-16 aspect-h-9">
                  <img 
                    src={training.image_url} 
                    alt={training.title}
                    className="w-full h-48 object-cover"
                  />
                </div>
                <div className="p-6">
                  <div className="flex items-center justify-between mb-3">
                    <span className="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-primary-100 text-primary-800">
                      {training.category}
                    </span>
                    <span className="text-2xl font-bold text-primary-600">
                      {training.price} zł
                    </span>
                  </div>
                  <h3 className="text-xl font-semibold text-gray-900 mb-3">
                    {training.title}
                  </h3>
                  <p className="text-gray-600 mb-4 line-clamp-3">
                    {training.description}
                  </p>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center space-x-2">
                      <img 
                        src={training.trainers?.photo_url} 
                        alt={training.trainers?.name}
                        className="w-8 h-8 rounded-full object-cover"
                      />
                      <span className="text-sm text-gray-600">{training.trainers?.name}</span>
                    </div>
                    <Link 
                      to={`/szkolenia/${training.id}`}
                      className="text-primary-600 hover:text-primary-700 font-medium text-sm"
                    >
                      Zobacz więcej →
                    </Link>
                  </div>
                </div>
              </div>
            ))}
          </div>
          
          <div className="text-center mt-12">
            <Link to="/szkolenia" className="btn-primary">
              Zobacz wszystkie szkolenia
            </Link>
          </div>
        </div>
      </section>

      {/* Trainers Section */}
      <section className="py-20 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl lg:text-4xl font-bold text-gray-900 mb-4">
              Nasi eksperci
            </h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              Poznaj doświadczonych trenerów, którzy poprowadzą Cię przez proces rozwoju
            </p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {trainers.map((trainer) => (
              <div key={trainer.id} className="text-center">
                <div className="relative mb-6">
                  <img 
                    src={trainer.photo_url} 
                    alt={trainer.name}
                    className="w-32 h-32 rounded-full mx-auto object-cover shadow-lg"
                  />
                  <div className="absolute -bottom-2 left-1/2 transform -translate-x-1/2 bg-primary-600 text-white px-3 py-1 rounded-full text-sm font-medium">
                    {trainer.specialization}
                  </div>
                </div>
                <h3 className="text-xl font-semibold text-gray-900 mb-2">
                  {trainer.name}
                </h3>
                <p className="text-gray-600 mb-4">
                  {trainer.bio}
                </p>
                <div className="flex justify-center space-x-2">
                  <span className="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-gray-100 text-gray-800">
                    {trainer.experience_years}+ lat doświadczenia
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 bg-primary-600">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-3xl lg:text-4xl font-bold text-white mb-6">
            Gotowy na rozwój swoich kompetencji?
          </h2>
          <p className="text-xl text-primary-100 mb-8 max-w-3xl mx-auto">
            Dołącz do setek zadowolonych uczestników naszych szkoleń. 
            Rozpocznij swoją podróż rozwoju już dziś.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link to="/szkolenia" className="btn-primary bg-white text-primary-600 hover:bg-gray-100">
              Wybierz szkolenie
            </Link>
            <Link to="/testy" className="btn-secondary border-primary-300 text-white hover:bg-primary-500">
              Sprawdź swoje kompetencje
            </Link>
          </div>
        </div>
      </section>

      <Footer />
    </div>
  );
}
