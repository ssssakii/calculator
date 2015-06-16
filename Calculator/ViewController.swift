//
//  ViewController.swift
//  Calculator
//
//  Created by Takatoshi Watanabe on 2015/06/15.
//  Copyright (c) 2015年 渡辺 貴俊. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var label : UILabel!
    var myLabel: UILabel!
    
    var number1 : Int = 0
    var number2 : Int = 0
    var number3 : Int = 0
    var operation : Int = 0
    var count : Int = 0
    
    override func viewDidLoad() {
        // Labelを生成
        myLabel = UILabel(frame: CGRectMake(0, 0, 200, 50))
        myLabel.backgroundColor = UIColor(red: 1.0, green: 0.737, blue: 0.261, alpha: 1.0)
        myLabel.center = self.view.center
        myLabel.text = "そろばんも使って〜(>_<)"
        myLabel.textAlignment = NSTextAlignment.Center
        myLabel.textColor = UIColor.whiteColor()
        
        // SegmentesControllerを生成.
        let mySegcon = UISegmentedControl(items: ["Spring", "Invert", "Rotate", "Scaling", "Move"])
        mySegcon.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height - 50)
        mySegcon.tintColor = UIColor.blueColor()
        mySegcon.addTarget(self, action: "changedValue:", forControlEvents: UIControlEvents.ValueChanged)
        
        // Labelをviewに追加
        self.view.addSubview(myLabel)
        
        // SegmentedControllerをviewに追加.
        self.view.addSubview(mySegcon)
    }
    
    
    /*
    SegmentedControllerの値が変わった時に呼ばれるメソッド.
    */
    func changedValue(sender: UISegmentedControl) {
        
        myLabel.center = self.view.center
        
        // 各アニメーションの処理.
        switch(sender.selectedSegmentIndex) {
            
            /*
            バネのような動きをするアニメーション.
            */
        case 0:
            // アニメーションの時間を2秒に設定.
            UIView.animateWithDuration(2.0,
                
                // 遅延時間.
                delay: 0.0,
                
                // バネの弾性力. 小さいほど弾性力は大きくなる.
                usingSpringWithDamping: 0.2,
                
                // 初速度.
                initialSpringVelocity: 1.5,
                
                // 一定の速度.
                options: UIViewAnimationOptions.CurveLinear,
                
                animations: { () -> Void in
                    
                    self.myLabel.layer.position = CGPointMake(self.view.frame.width-50, 100)
                    
                    // アニメーション完了時の処理
                }) { (Bool) -> Void in
                    self.myLabel.center = self.view.center
            }
            
            /*
            X, Y方向にそれぞれ反転するアニメーション.
            */
        case 1:
            // アニメーションの時間を3秒に設定
            UIView.animateWithDuration(3.0,
                
                // アニメーション中の処理
                animations: { () -> Void in
                    
                    // X方向に反転用のアフィン行列作成
                    self.myLabel.transform = CGAffineTransformScale(self.myLabel.transform, -1.0, 1.0)
                    
                    // 連続したアニメーション処理.
                }) { (Bool) -> Void in
                    UIView.animateWithDuration(3.0,
                        
                        // アニメーション中の処理
                        animations: { () -> Void in
                            
                            // Y方向に反転用のアフィン行列作成
                            self.myLabel.transform = CGAffineTransformScale(self.myLabel.transform, 1.0, -1.0)
                            
                            // アニメーション完了時の処理
                        }) { (Bool) -> Void in
                    }
            }
            
            /*
            回転アニメーション.
            */
        case 2:
            // 初期化.
            self.myLabel.transform = CGAffineTransformMakeRotation(0)
            
            // radianで回転角度を指定(90度).
            let angle:CGFloat = CGFloat(M_PI_2)
            
            // アニメーションの秒数を設定(3秒).
            UIView.animateWithDuration(3.0,
                
                animations: { () -> Void in
                    
                    // 回転用のアフィン行列を生成.
                    self.myLabel.transform = CGAffineTransformMakeRotation(angle)
                },
                completion: { (Bool) -> Void in
            })
            
            /*
            拡縮アニメーション.
            */
        case 3:
            self.myLabel.transform = CGAffineTransformMakeScale(1, 1)
            
            // アニメーションの時間を3秒に設定.
            UIView.animateWithDuration(3.0,
                
                animations: { () -> Void in
                    // 縮小用アフィン行列を作成.
                    self.myLabel.transform = CGAffineTransformMakeScale(1.5, 1.5)
                }) // 連続したアニメーション処理.
                { (Bool) -> Void in
                    UIView.animateWithDuration(3.0,
                        // アニメーション中の処理.
                        animations: { () -> Void in
                            // 拡大用アフィン行列を作成.
                            self.myLabel.transform = CGAffineTransformMakeScale(0.5, 0.5)
                        }) // アニメーション完了時の処理.
                        { (Bool) -> Void in
                            // 大きさを元に戻す.
                            self.myLabel.transform = CGAffineTransformMakeScale(1, 1)
                    }
            }
            
            /*
            移動するアニメーション.
            */
        case 4:
            myLabel.layer.position = CGPointMake(-30, -30)
            
            // アニメーション処理
            UIView.animateWithDuration(NSTimeInterval(CGFloat(3.0)),
                animations: {() -> Void in
                    
                    // 移動先の座標を指定する.
                    self.myLabel.center = CGPoint(x: self.view.frame.width/2,y: self.view.frame.height/2);
                    
                }, completion: {(Bool) -> Void in
            })
            
        default:
            println("error!")
        }
    }
    
    
    
    //0から9のボタン
    @IBAction func select0(){
        number1 = number1*10 + 0
        label.text = String(number1)
    }
    @IBAction func select1(){
        number1 = number1*10 + 1
        label.text = String(number1)
    }
    @IBAction func select2(){
        number1 = number1*10 + 2
        label.text = String(number1)
    }
    @IBAction func select3(){
        number1 = number1*10 + 3
        label.text = String(number1)
    }
    @IBAction func select4(){
        number1 = number1*10 + 4
        label.text = String(number1)
    }
    @IBAction func select5(){
        number1 = number1*10 + 5
        label.text = String(number1)
    }
    @IBAction func select6(){
        number1 = number1*10 + 6
        label.text = String(number1)
    }
    @IBAction func select7(){
        number1 = number1*10 + 7
        label.text = String(number1)
    }
    @IBAction func select8(){
        number1 = number1*10 + 8
        label.text = String(number1)
    }
    @IBAction func select9(){
        number1 = number1*10 + 9
        label.text = String(number1)
    }
    
    
    //四則演算記号とクリアボタン
    @IBAction func plus(){
        label.text = String(0)
        
        operation = 1
        if count == 0{
            number2 = number1
            count = 1
        }
        number1 = 0
    }
    @IBAction func minus(){
        label.text = String(0)
        
        operation = 2
        if count == 0{
            number2 = number1
            count = 1
        }
        number1 = 0
    }
    @IBAction func multi(){
        label.text = String(0)
        
        operation = 3
        if count == 0{
            number2 = number1
            count = 1
        }
        number1 = 0
    }
    @IBAction func div(){
        label.text = String(0)
        
        operation = 4
        if count == 0{
            number2 = number1
            count = 1
        }
        number1 = 0
    }
    @IBAction func clear(){
        label.text = String(0)
        
        number1 = 0
        number2 = 0
        number3 = 0
        count = 0
    }
    
    //以下計算機能
    @IBAction func equal(){
        number3 = number1
        if operation == 1{
            if count > 0{
                number2 = number3 + number2
            }else {
                number2 = number2 + number1
                count = 1
            }
            label.text = String(number2)
            
        }else if operation == 2{
            if count > 0{
                number2 = number2 - number3
            }else {
                number2 = number2 - number1
                count = 1
            }
            label.text = String(number2)
            
            
        }else if operation == 3{
            if count > 0{
                number2 = number2 * number3
            }else {
                number2 = number2 * number1
                count = 1
            }
            label.text = String(number2)
            
        }else if operation == 4{
            if count > 0{
                number2 = number2 / number3
            }else {
                number2 = number2 / number1
                count = 1
            }
            label.text = String(number2)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

