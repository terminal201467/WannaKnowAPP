//
//  SignUpViewController.swift
//  想知道嗎論壇APP
//
//  Created by Jhen Mu on 2022/1/19.
//

import UIKit

class SignUpViewController: UIViewController{
    
    //MARK:-Properties
    
    let signUpView = SignUpView()
    
    let dataBase = SignUpDataBase()
    
    let scrollView = UIScrollView()
    
    private var store:WannaKnowData.Data = WannaKnowData.Data(wanna_know_id: "",
                                                      category: "",
                                                      title: "",
                                                      description: "",
                                                      speaker: "",
                                                      date: "",
                                                      year: "",
                                                      live: "",
                                                      tags: [String](),
                                                      like: "",
                                                      attachment: "",
                                                      update_time: "",
                                                      comment_amount: "")
    
    private var category = String()
    
    private var mode = String()
    
    private var date = String()
    
    override func loadView() {
        super.loadView()
        view = signUpView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDropDownListAction()
        setTextFieldDelegate()
        setTextFieldAndTextViewTags()
        setTagButtons()
        setSegmentAction()
        setDatePicker()
    }
    
    private func setTextFieldDelegate(){
        signUpView.speechPersonColumn.textField.delegate = self
        signUpView.themeColumn.textField.delegate = self
        signUpView.linkInfo.textField.delegate = self
        signUpView.tags.textField.delegate = self
        signUpView.textView.delegate = self
    }
    
    private func setTagButtons(){
        signUpView.tagButtons.delegate = self
        signUpView.tagButtons.dataSource = self
    }
    
    private func setTextFieldAndTextViewTags(){
        signUpView.speechPersonColumn.textField.tag = 0
        signUpView.themeColumn.textField.tag = 1
        signUpView.linkInfo.textField.tag = 2
        signUpView.tags.textField.tag = 3
    }
    
    private func appendTextToTags(){
        dataBase.appendToStore(text: signUpView.tags.textField.text!)
        signUpView.tagButtons.reloadData()
        signUpView.tags.textField.text = ""

    }
    
    private func setSendButton(){
        signUpView.sendButton.addTarget(self, action: #selector(send), for: .touchDown)
    }
    
    @objc func send(){
        //append the data to dataBase Array
        //Check:if one of the colum did't sign up the column,so do not send out the infomation
        //
        
        
        
//        store = WannaKnowData.Data(wanna_know_id: "",
//                                   category: category,
//                                   title: signUpView.themeColumn.textField.text!,
//                                   description: signUpView.textView.text!,
//                                   speaker: signUpView.speechPersonColumn.textField.text!,
//                                   date: <#T##String#>,
//                                   year: <#T##String#>,
//                                   live: <#T##String#>,
//                                   tags: dataBase.store,
//                                   like: <#T##String#>,
//                                   attachment: <#T##String#>,
//                                   update_time: <#T##String#>,
//                                   comment_amount: <#T##String#>)
        
    }
    
    private func tagBasedTextField(_ textField:UITextField){
        let newTextFieldTag = textField.tag + 1
        if let nextTextField = signUpView.superview!.viewWithTag(newTextFieldTag) as? UITextField{
            nextTextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
    }


    private func editTextViewHeight(_ textView:UITextView){
        if view.frame.origin.y == 0{
            view.frame.origin.y -= textView.frame.height + 50
        }
    }
    
    //MARK:-DropDownAction
    private func setDropDownListAction(){
        signUpView.kindChooser.kindPicker.addTarget(self, action: #selector(drop), for: .touchUpInside)
    }
    
    @objc func drop(sender: UIButton) {
        signUpView.kindChooser.dropDownList.dataSource = ["請選擇分類", "專案經驗", "學習小心得", "技術剖析", "職場工作", "生活頻道"]
        signUpView.kindChooser.dropDownList.anchorView = sender
        signUpView.kindChooser.dropDownList.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        signUpView.kindChooser.dropDownList.show()
        signUpView.kindChooser.dropDownList.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            sender.setTitle(item, for: .normal)
            //如果選擇“請選擇分類”，就不回傳東西
            //反之，就回傳選擇的String
            if item == "請選擇分類"{
                print("Nothing to choose")
            }else{
                print("Choose:",item)
                self!.category = item
            }
        }
    }
    
    private func setDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        date = formatter.string(from: signUpView.speechDatePicker.datePicker.date)
        print("時間：",date)
    }
    
    //MARK:-SegmentAction
    private func setSegmentAction(){
        signUpView.speechFormChooser.formPicker.addTarget(self, action: #selector(pickMode), for: .valueChanged)
    }
    
    @objc func pickMode(sender:UISegmentedControl){
        mode = signUpView.speechFormChooser.formPicker.titleForSegment(at: sender.selectedSegmentIndex)!
        print("選擇主題：",mode)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if view.frame.origin.y != 0{
            view.frame.origin.y = 0
        }
    }
}

extension SignUpViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataBase.numberOfRowInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.reuseIdentifier, for: indexPath) as! TagCell
        tagCell.tagLabel.text = dataBase.cellForItemAt(index: indexPath)
        return tagCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataBase.removeAt(indexPath)
        collectionView.reloadData()
    }
}

extension SignUpViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tagBasedTextField(textField)
        if textField.tag == 3{
            if textField.text != "" && dataBase.tagStore.count < 5{
                appendTextToTags()
            }else{
                self.view.endEditing(true)
                textField.text = ""
            }
        }
        return true
    }
}

extension SignUpViewController:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            self.view.endEditing(true)
            if view.frame.origin.y != 0{
                view.frame.origin.y = 0
            }
        }
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        editTextViewHeight(textView)
        return true
    }
}
