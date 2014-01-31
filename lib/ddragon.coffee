request = require 'request'

debug = false
language = 'en_US'
game_version = '4.1.2'

base_url = "http://ddragon.leagueoflegends.com/cdn/#{game_version}/"

module.exports.champion_image_url = "#{base_url}img/champion/"
module.exports.item_image_url = "#{base_url}img/item/"
module.exports.profile_icon_image_url = "#{base_url}img/profileicon/"

module.exports.getChampions = (next) ->
  url = buildApiUrl('champion.json')
  makeRequest(url, next)

module.exports.getItems = (next) ->
  url = buildApiUrl('item.json')
  makeRequest(url, next)

buildApiUrl = (path) ->
  "#{base_url}data/#{language}/#{path}"

makeRequest = (url, next) ->
  if debug
    console.log('Calling url', url);

  request.get url, (err, res, body) ->
    return next(err) if err

    if res.statusCode == 200
      try
        body = JSON.parse(body)
        next(null, body)
      catch e
        next(e)
    else if res.statusCode == 404
      next({ status: { message: 'Not found', code: 404 } })
    else if res.statusCode == 429
      next({ status: { message: 'Rate limit exceeded', code: 429 } })
    else if res.statusCode == 500
      next({ status: { message: 'Internal server error', code: 500 } })
    else
      next({ status: { message: 'Unhandled http response status code', code: res.statusCode } })
