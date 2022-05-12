package com.example.demo.controller;

import java.util.Arrays;
import java.util.List;

import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.example.bean.WeatherDetails;

@RestController
public class HelloWorldController {

	
	@Value("${API.host}")
	private String host;
	
	@Value("${API.path}")
	private String path;
	
	@Value("${API.key}")
	private String apiKey;
	
	@PostMapping("/weather")
	public WeatherDetails getWeatherDetails(@RequestParam String showUnit, @RequestParam String city) {
		
		UriComponents uriComponents = UriComponentsBuilder
				.newInstance()
				.scheme("http")
				.host(host)
			    .path(path)
			    .query("q={keyword}&appid={appid}&units={unit}")
			    .buildAndExpand(city,apiKey,showUnit);
		
		String url = uriComponents.toUriString();
		RestTemplate restTemplate = new RestTemplate();
		WeatherDetails weatherDetails = restTemplate.getForObject(url, WeatherDetails.class);
		ModelAndView mav = new ModelAndView("welcome");
        return weatherDetails;
	}
	
	@GetMapping("/")
    public ModelAndView hello(Model model, @RequestParam(value="name", required=false, defaultValue="World") String name) {
		ModelAndView mav = new ModelAndView("welcome");
        return mav;
    }
}
