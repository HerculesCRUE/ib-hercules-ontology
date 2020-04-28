package es.weso.asio.ontology.validate;

import es.weso.shapeMaps.ResultShapeMap;
import es.weso.shapeMaps.ShapeMap;

/**
 * Represents a object with the validation result shapeMap and the expected
 * result shapeMap
 * 
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
