package es.weso.asio.ontology.validate;

import es.weso.shapeMaps.ResultShapeMap;
import es.weso.shapeMaps.ShapeMap;

/**
 * Saves the validation result and the expected result
 * @author Jose Emilio Labra Gayo
 *
 */
public class ResultValidation {

	private final ResultShapeMap resultShapeMap;
	private final ShapeMap expectedShapeMap;

	public ResultValidation(final ResultShapeMap resultShapeMap, final ShapeMap expectedShapeMap) {
		this.resultShapeMap = resultShapeMap;
		this.expectedShapeMap = expectedShapeMap;
	}

	public ShapeMap getResultShapeMap() {
		return resultShapeMap;
	}

	public ShapeMap getExpectedShapeMap() {
		return expectedShapeMap;
	}

}
