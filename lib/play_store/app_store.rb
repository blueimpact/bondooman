module PlayStore
  module AppStore
    extend ActiveSupport::Autoload
    autoload :Crawler

    GENRES = {
      all: nil,
      books: '6018',
      business: '6000',
      catalogs: '6022',
      education: '6017',
      entertainment: '6016',
      finance: '6015',
      food_and_drink: '6023',
      games: '6014',
      health_and_fitness: '6013',
      lifestyle: '6012',
      medical: '6020',
      music: '6011',
      navigation: '6010',
      news: '6009',
      newsstand: '6021',
      photo_and_video: '6008',
      productivity: '6007',
      reference: '6006',
      socialnetworking: '6005',
      sports: '6004',
      travel: '6003',
      utilities: '6002',
      weather: '6001'
    }

    SEGMENTS = {
      paid: 'toppaidapplications',
      free: 'topfreeapplications',
      gross: 'topgrossingapplications'
    }
  end
end
