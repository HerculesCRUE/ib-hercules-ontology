package es.weso.asio.ontology.shex;

import java.util.logging.Logger;

import org.joda.time.Instant;
import org.joda.time.Period;
import org.joda.time.format.PeriodFormat;

import cats.effect.IO;
import es.weso.asio.ontology.Main;
import es.weso.shapeMaps.ResultShapeMap;
import es.weso.shexsjava.ArgsParser;
import es.weso.shexsjava.Validate;

public class ShExValidator {
	
	private boolean isVerbose = false;
	
	public void validate(String[] args) {
		
		Logger log = Logger.getLogger(Main.class.getName());
		Instant start = Instant.now();
		
		ArgsParser options = new ArgsParser(args);

		isVerbose = options.verbose;
		Validate validator = new Validate();

		verbose("Data: " + options.data + ". Schema: " + options.schema + ". ShapeMap: " + options.shapeMap);

		IO<ResultShapeMap> validate = validator.validate(options.data, options.dataFormat, options.schema,
				options.schemaFormat, options.shapeMap, options.shapeMapFormat);

		try {
			ResultShapeMap result = validate.unsafeRunSync();
			System.out.println(result.toJson().spaces2());
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		}
		Instant end = Instant.now();
		if (options.printTime)
			printTime(start, end);
	}
	
	
	
	private void verbose(String msg) {
		if (isVerbose) {
			System.out.println(msg);
		}
	}

	private void printTime(Instant start, Instant end) {
		Period timeElapsed = new Period(start, end);
		System.out.println("Time elapsed " + PeriodFormat.getDefault().print(timeElapsed));
	}
	
}
