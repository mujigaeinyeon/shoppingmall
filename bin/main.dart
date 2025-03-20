import 'dart:io';
import 'package:console_shoppingmaill/shopping_mall.dart';

void main() {
  String? number;
  var mall = ShoppingMall();

  do {
    print('--------------------------------------------------------------------------------------------------------------------------');
    print('[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료 / [6] 장바구니 초기화 / [7] 장바구니 상품 구매');
    print('--------------------------------------------------------------------------------------------------------------------------');
  
    number = stdin.readLineSync();

    switch(number) {
      case '1':
        // 필수1 - 상품 목록을 출력하는 메서드
        mall.showProducts();
      case '2':
        // 필수2 - 상품을 장바구니에 담는 메서드
        addToCart(mall);   
      case '3':
        // 필수3 - 장바구니에 담은 상품들의 총 가격을 볼 수 있는 기능
        // 도전3 -  장바구니에 담은 상품들의 목록과 가격을 볼 수 있는 기능
        print('장바구니에 ${mall.showBucketProductNames()}가 담겨있네요. 총 ${mall.showTotal()}원 입니다!');
      case '4':
        // 필수4 - 쇼핑몰 프로그램을 종료할 수 있는 기능
        print('정말 종료하시겠습니까? [5]를 입력하시면 종료됩니다.');
        number = stdin.readLineSync();

        // 도전1 - 쇼핑몰 프로그램을 종료할 시 한번 더 종료할 것인지 물어보는 기능
        if(number == '5') {
          print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
        } else {
          print('종료하지 않습니다.');
        }
      case '6':
        // 도전2 - 장바구니를 초기화하는 기능
        if(mall.showTotal() == 0) {
          print('이미 장바구니가 비어있습니다.');
        } else {
          mall.resetBucket();
          print('장바구니를 초기화합니다.');
        }
      case '7':
        // 도전4 - 장바구니 상품 구매 (자유구현)
        if(mall.showTotal() == 0) {
          print('이미 장바구니가 비어있습니다.');
        } else {
          print('장바구니에 ${mall.showBucketProductNames()}가 담겨있네요. 총 ${mall.showTotal()}원 입니다! 구매하시려면 Y를 입력해주세요.');
          var answer = stdin.readLineSync();
          if(answer == 'Y') {
            mall.stockManage();
            mall.resetBucket();
            print('구매가 완료되었습니다. 장바구니를 초기화합니다.');
          } else {
            print('구매가 취소되었습니다.');
          }
        }  
      default:
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  } while (number != '5');
}

void addToCart(ShoppingMall mall) {
  print('상품의 이름을 입력해주세요!');
  var name = stdin.readLineSync();
  if(!mall.checkProduct(name)) {
    print('입력값이 올바르지 않아요 !');
    return;
  }

  print('상품의 개수를 입력해주세요!');
  var count = int.tryParse(stdin.readLineSync() ?? '');
  if(count == null) {
    print('입력값이 올바르지 않아요 !');
    return;
  } else if(count <= 0) {
    print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
    return;
  }

  if(!mall.checkProductCount(name, count)) {
    print('현재 제품 재고 수량이 부족합니다 ! (재고수량 >= 장바구니 수량 + 추가 수량) 이어야 합니다.');
    return;
  }

  mall.addToCart(name, count);
  print('장바구니에 담습니다.');
}
