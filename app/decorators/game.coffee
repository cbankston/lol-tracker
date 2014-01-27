_ = require 'underscore'
moment = require 'moment'
irelia = require '../../lib/irelia'
Champion = require '../dal/champion'
ChampionDecorator = require './champion'

formatNumber = (num) ->
  num = num || 0
  parts = num.toString().split(".")
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",")
  parts.join(".")

class GameDecorator
  constructor: (@model) ->

  decorate: (next) ->
    attributes = @buildAttributes()

    unless attributes.champion
      @populateChampion(attributes, next)
    else
      next(err, attributes)

  populateChampion: (attributes, next) ->
    Champion.find attributes.championId, (err, champion) ->
      ChampionDecorator champion, (err, decorated_champion) ->
        attributes.champion = decorated_champion
        next(err, attributes)

  buildAttributes: () ->
    attributes = _.extend @model,
      gameMode: @gameMode(),
      gameType: @gameType(),
      createDate: @createDate(),
      subType: @subType(),
      map: @map(),
      win_css: win_css

    attributes.stats = _.extend @model.stats,
      assists: @model.stats.assists || 0,
      championsKilled: @model.stats.championsKilled || 0,
      goldEarned: formatNumber(@model.stats.goldEarned),
      goldSpent: formatNumber(@model.stats.goldSpent),
      #largestCriticalStrike: formatNumber(@model.stats.largestCriticalStrike),
      magicDamageTaken: formatNumber(@model.stats.magicDamageTaken),
      numDeaths: @model.stats.numDeaths || 0,
      physicalDamageDealtToChampions: formatNumber(@model.stats.physicalDamageDealtToChampions),
      physicalDamageDealtPlayer: formatNumber(@model.stats.physicalDamageDealtPlayer),
      physicalDamageTaken: formatNumber(@model.stats.physicalDamageTaken),
      timePlayed: @timePlayed(),
      totalDamageDealtToChampions: formatNumber(@model.stats.totalDamageDealtToChampions),
      #totalHeal: formatNumber(@model.stats.totalHeal),
      totalDamageTaken: formatNumber(@model.stats.totalDamageTaken),
      totalDamageDealt: formatNumber(@model.stats.totalDamageDealt),
      #trueDamageTaken: formatNumber(@model.stats.trueDamageTaken),
      win: @win(),

    return attributes

  createDate: () ->
    date = new Date(Number(@model.createDate))
    moment(date).fromNow()

  gameMode: () ->
    if @model.gameMode == 'CLASSIC'
      player_count = @model.fellowPlayers.length
      if player_count == 9
        '5v5'
      else if player_count == 4
        '5v5'
      else
        '3v3'
    else if @model.gameMode == 'ODIN'
      'Dominion'
    else if @model.gameMode == 'ARAM'
      'Aram'
    else
      irelia.gamemode[@model.gameMode]

  gameType: () ->
    irelia.gametypes[@model.gameType]

  map: () ->
    if @model.mapId == '1'
      'Summoners Rift'
    else if @model.mapId == '8'
      'The Crystal Scar'
    else if @model.mapId == '12'
      'Howling Abyss'
    else
      @model.mapId

  subType: () ->
    type = @model.subType

    if type == 'NORMAL'
      'Normal'
    else if type == 'BOT'
      'Bot'
    else if type == 'RANKED_SOLO_5x5'
      'Ranked Solo'
    else if type == 'ARAM_UNRANKED_5x5'
      'Normal'
    else if type == 'ODIN_UNRANKED'
      'Normal'
    else
      type

  timePlayed: () ->
    moment.duration(@model.stats.timePlayed, 'seconds').humanize()

  win: () ->
    if @model.stats.win then 'Victory' else 'Defeat'

win_css = () ->
  'success'

module.exports = (model, next) ->
  new GameDecorator(model).decorate(next)
