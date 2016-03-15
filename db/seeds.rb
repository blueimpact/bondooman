Segment.find_or_create_by(name: 'paid', label: 'トップ有料')
Segment.find_or_create_by(name: 'free', label: 'トップ無料')
Segment.find_or_create_by(name: 'gross', label: 'トップセールス')

Genre.find_or_create_by(name: 'all', label: '全て')
Genre.find_or_create_by(name: 'games', label: 'ゲーム')
