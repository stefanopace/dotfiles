render_forecast () {
	json="$(cat)"

	city_name=$(echo "$json" | jq .city.name)
	lat=$(echo "$json" | jq .city.coord.lat)
	lon=$(echo "$json" | jq .city.coord.lon)
	population=$(echo "$json" | jq .city.population)
	sunrise=$(date -d @$(echo "$json" | jq .city.sunrise) '+%X')
	sunset=$(date -d @$(echo "$json" | jq .city.sunset) '+%X')

	echo "$(echo $city_name | tr -d '"')"
	echo "popolazione: ${population}\n\
lat: ${lat} | alba: | ${sunrise}\n\
lon: ${lon} | tramonto: | ${sunset}" | column -t -s '|'
	echo

	count=$(echo "$json" | jq .cnt)
	for i in $(seq 0 $(expr $count - 1)); do
		date=$(date -d @$(echo "$json" | jq .list[$i].dt))
		temp=$(echo "$json" | jq .list[$i].main.temp)
		feels_like_temp=$(echo "$json" | jq .list[$i].main.feels_like)
		humidity=$(echo "$json" | jq .list[$i].main.humidity)
		description=$(echo "$json" | jq .list[$i].weather[0].description)
		clouds=$(echo "$json" | jq .list[$i].clouds.all)
		wind_speed=$(echo "$json" | jq .list[$i].wind.speed)
		pop=$(echo "scale=0; ($(echo "$json" | jq .list[$i].pop) * 100) / 1" | bc)
		rain=$(echo "$json" | jq -c .list[$i].rain)
		if [ "$rain" != 'null' ]; then
			rain_mm=$(echo "$rain" | jq '.["3h"]')
			rain="pioggia: $rain_mm mm"
		else
			rain=''
		fi
		snow=$(echo "$json" | jq -c .list[$i].snow)
		if [ "$snow" != 'null' ]; then
			snow_mm=$(echo "$snow" | jq '.["3h"]')
			snow="pioggia: $snow_mm mm"
		else
			snow=''
		fi

		echo $(echo "${date} -> ${description}" | tr -d '"')
		echo "temperatura: ${temp} °C | nuvole: ${clouds}% | umidità: ${humidity}%\n\
percepita: ${feels_like_temp} °C | vento: ${wind_speed} m/s | probabilità di precipitazioni: ${pop}%\n\
$rain | $snow" | column -t -s '|'

		echo
	done
}