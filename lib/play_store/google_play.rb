module PlayStore
  module GooglePlay
    extend ActiveSupport::Autoload
    autoload :Crawler

    GENRES = {
      all: nil,
      game: 'GAME',
      family: 'FAMILY',
      app_widgets: 'APP_WIDGETS',
      entertainment: 'ENTERTAINMENT',
      personalization: 'PERSONALIZATION',
      comics: 'COMICS',
      shopping: 'SHOPPING',
      sports: 'SPORTS',
      social: 'SOCIAL',
      tools: 'TOOLS',
      news_and_magazines: 'NEWS_AND_MAGAZINES',
      business: 'BUSINESS',
      finance: 'FINANCE',
      media_and_video: 'MEDIA_AND_VIDEO',
      lifestyle: 'LIFESTYLE',
      libraries_and_demo: 'LIBRARIES_AND_DEMO',
      app_wallpaper: 'APP_WALLPAPER',
      medical: 'MEDICAL',
      music_and_audio: 'MUSIC_AND_AUDIO',
      education: 'EDUCATION',
      health_and_fitness: 'HEALTH_AND_FITNESS',
      transportation: 'TRANSPORTATION',
      productivity: 'PRODUCTIVITY',
      photography: 'PHOTOGRAPHY',
      books_and_reference: 'BOOKS_AND_REFERENCE',
      communication: 'COMMUNICATION',
      weather: 'WEATHER',
      travel_and_local: 'TRAVEL_AND_LOCAL'
    }

    SEGMENTS = {
      paid: 'topselling_paid',
      free: 'topselling_free',
      gross: 'topgrossing'
    }
  end
end
