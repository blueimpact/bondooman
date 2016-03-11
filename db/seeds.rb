Segment.find_or_create_by(name: 'paid', label: 'トップ有料 App')
Segment.find_or_create_by(name: 'free', label: 'トップ無料 App')
Segment.find_or_create_by(name: 'gross', label: 'トップセールス App')

Genre.find_or_create_by(name: 'all', label: '全て')
Genre.find_or_create_by(name: 'games', label: 'ゲーム')
