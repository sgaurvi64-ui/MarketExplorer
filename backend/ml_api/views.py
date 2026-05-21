from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import PredictionSnapshot
from .serializers import PredictionSnapshotSerializer
from .services import InsightEngine


engine = InsightEngine()


@api_view(['GET'])
def ml_home(request):
    return Response({
        'module': 'ml_api',
        'status': 'ok',
        'message': 'ML API is ready.',
        'engine': engine.engine_status(),
    })


@api_view(['GET'])
def predict_stock(request, symbol):
    horizon = request.query_params.get("horizon", "short")
    payload = engine.predict(symbol, horizon=horizon)
    snapshot = PredictionSnapshot.objects.create(
        symbol=payload['symbol'],
        prediction=payload['prediction'],
        confidence=payload['confidence'],
        risk_score=payload['risk_score'],
        source=payload['source'],
    )
    return Response(PredictionSnapshotSerializer(snapshot).data)


@api_view(['GET', 'POST'])
def recommendation_summary(request):
    return Response({
        'engine': engine.engine_status(),
        'results': engine.recommend(),
    })


@api_view(['GET'])
def engine_status(request):
    horizon = request.query_params.get("horizon", "short")
    return Response({
        'engine': engine.engine_status(),
        'metadata': engine.model_metadata(horizon=horizon),
    })
