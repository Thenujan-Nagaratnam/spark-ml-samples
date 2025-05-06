package com.lohika.morning.ml.api.controller;

import com.lohika.morning.ml.api.service.LyricsService;
import com.lohika.morning.ml.spark.driver.service.lyrics.GenrePrediction;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/lyrics")
public class LyricsController {

    @Autowired
    private LyricsService lyricsService;

    @RequestMapping(value = "/train", method = RequestMethod.GET)
    ResponseEntity<Map<String, Object>> trainLyricsModel() {
        Map<String, Object> trainStatistics = lyricsService.classifyLyrics();

        return new ResponseEntity<>(trainStatistics, HttpStatus.OK);
    }

    @RequestMapping(value = "/predict", method = RequestMethod.POST)
    ResponseEntity<GenrePrediction> predictGenre(@RequestBody String unknownLyrics) {
        GenrePrediction genrePrediction = lyricsService.predictGenre(unknownLyrics);

        return new ResponseEntity<>(genrePrediction, HttpStatus.OK);
    }

    @RequestMapping(value = "/", method = RequestMethod.GET, produces = "text/html")
    public ResponseEntity<String> getLyrics() {
        try {
            String htmlContent = new String(
                Files.readAllBytes(Paths.get("src/main/resources/static/index.html"))
            );
            return new ResponseEntity<>(htmlContent, HttpStatus.OK);
        } catch (IOException e) {
            return new ResponseEntity<>("Error loading the page", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
