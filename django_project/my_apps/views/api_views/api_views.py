from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from ...models import CartItem
from ...serializers import CartItemSerializer

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def cart_summary(request):
    cart_items = CartItem.objects.filter(user=request.user)
    serializer = CartItemSerializer(cart_items, many=True)
    return Response({'items': serializer.data})
