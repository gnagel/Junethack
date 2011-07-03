require 'orderedhash'

$trophies = [
 'most_ascensions',
 'longest_ascension_streak',
 'fastest_ascension_gametime',
 'fastest_ascension_realtime',
 'highest_scoring_ascension',
 'lowest_scoring_ascension',
 'most_conducts'
]

$trophies_name = [
 "Most ascensions",
 "Longest ascension streak",
 "Fastest ascension (gametime)",
 "Fastest ascension (realtime)",
 "Highest scoring ascension",
 "Lowest scoring ascension",
 "Most conducts in a single ascension"
]

$variants_mapping = OrderedHash.new
$variants_mapping["3.4.3"]     = "NetHack 3.4.3"
$variants_mapping["UNH-3.5.4"] = "UnNetHack"
$variants_mapping["3.6.0"]     = "AceHack"
$variants_mapping["0.6.3"]     = "SporkHack"
$variants_mapping["NH-1.3d"]   = "NetHack 1.3d"

def helper_get_variants_for_user(id)
    variants = repository.adapter.select "select distinct version from games where user_id = ?;", @id
    v = $variants_mapping.dup.delete_if {|key,value| not variants.include? key }
end

def helper_get_score(key, variant)
    return repository.adapter.select "select (select login from users where user_id = id) as user, user_id, value from scoreentries where trophy = ? and variant = ? order by user;", key, variant
end