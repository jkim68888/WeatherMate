# WeatherMate

`위치`를 선택하면 해당 위치의 `날씨`를 `시간과 요일`에 따라 보여주는 ios 어플리케이션.

<div>
    <span>
        <img src="https://user-images.githubusercontent.com/75922558/182289456-90c722f4-eaf0-472f-801f-df106c996a21.png" width="180"/>
    </span>
    <span>
        <img src="https://user-images.githubusercontent.com/75922558/182289474-fc466f99-8c76-495d-9eea-08bcaf116ca9.png" width="180"/>
    </span>
    <span>
        <img src="https://user-images.githubusercontent.com/75922558/182289477-cc7c0a37-655d-438b-8a10-fd1eb3a355f3.png" width="180"/>
    </span>
    <span>
        <img src="https://user-images.githubusercontent.com/75922558/182289480-30c1b409-7cd8-4454-aebb-8cab2818ec1b.png" width="180"/>
    </span>
    <span>
        <img src="https://user-images.githubusercontent.com/75922558/182289482-e50018d5-14f7-4836-9143-dfa733123c9f.png" width="180"/>
    </span>
    <span>
        <img src="https://user-images.githubusercontent.com/75922558/182289483-63eb1b5a-dbf1-4089-bed9-2ee247f62891.png" width="180"/>
    </span>
    <span>
        <img src="https://user-images.githubusercontent.com/75922558/182289485-7a13f30b-dcf8-4917-ad3a-49abf9b13760.png" width="180"/>
    </span>
</div>

## 🚀 어플리케이션 제작

- 기간 : 2022.07.27 ~ 2022.08.02
- 언어 : Swift5
- 디자인패턴 : [MVVM](#-mvvm-패턴)
- Open API : [Rapid Api](#-오픈소스-api)
- http 통신 라이브러리 : Alamofire
- UI 라이브러리 : Sanpkit 5.6.0, Dropdown, Toast-Swift 5.0.1
- library dependancy manager: Cocoapods

## 📋 기능

- 날씨 정보를 원하는 `도시 선택` 가능
- `오늘 날씨`(온도, 풍속, 운량, 적설량, 날씨 이미지, 날씨 묘사 문구) 정보 제공
- 오늘의 `시간대별 날씨`(시간대, 온도, 날씨 이미지) 정보 제공
- 시간대별 날씨는 현재 시간을 기준으로 24시간(1시간 단위)로 제공
- 내일부터 `일주일간의 요일별 날씨`(요일, 최저기온, 최고기온, 날씨 이미지) 정보 제공
- API 호출 결과 `에러`가 떨어질 경우, `토스트 메시지` 출력

## 📍 MVVM 패턴

> Model - View - ViewModel

<!-- ![WeatherMate_MVVM](https://user-images.githubusercontent.com/75922558/183399149-7f6c6536-46a0-4eb3-bc39-28da337f7874.png) !-->

## 📍 오픈소스 API

> Rapid Api : [https://rapidapi.com/weatherbit/api/weather/](https://rapidapi.com/weatherbit/api/weather/)

```json
// Results

{
	"data": [
		{
			"moonrise_ts": 1659994693,
			"wind_cdir": "SSW",
			"rh": 67,
			"pres": 1010.9,
			"high_temp": 34.4,
			"sunset_ts": 1660003869,
			"ozone": 303.1,
			"moon_phase": 0.889039,
			"wind_gust_spd": 4.2,
			"snow_depth": 0,
			"clouds": 9,
			"ts": 1659931260,
			"sunrise_ts": 1659954458,
			"app_min_temp": 23,
			"wind_spd": 2.2,
			"pop": 0,
			"wind_cdir_full": "south-southwest",
			"moon_phase_lunation": 0.38,
			"slp": 1018.4,
			"app_max_temp": 36.9,
			"valid_date": "2022-08-08",
			"vis": 21.91,
			"snow": 0,
			"dewpt": 20.9,
			"uv": 8.1,
			"weather": {
				"icon": "c02d",
				"code": 801,
				"description": "Few clouds"
			},
			"wind_dir": 197,
			"max_dhi": null,
			"clouds_hi": 7,
			"precip": 0,
			"low_temp": 24.7,
			"max_temp": 34.4,
			"moonset_ts": 1659942702,
			"datetime": "2022-08-08",
			"temp": 28.6,
			"min_temp": 21.2,
			"clouds_mid": 0,
			"clouds_low": 8
		}
	],
	"city_name": "Four Oaks",
	"lon": -78.5,
	"timezone": "America/New_York",
	"lat": 35.5,
	"country_code": "US",
	"state_code": "NC"
}
```
