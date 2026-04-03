//
//  DetailFoodInfoPopup.swift
//  FoodKeeper
//
//  Created by psm on 3/24/26.
//

import UIKit

import FoodKeeperFoundation
import Domain

import SnapKit
import Then
import RxSwift
import RxCocoa

final class DetailFoodInfoPopup: BaseVC {
    private var foodInfo: FoodResponse
    private var isEditMode = false
    
    // MARK: - Constants
    private let titleLabelWidth: CGFloat = 70
    private let contentPadding: CGFloat = Design.Padding.regular_22
    private let rowSpacing: CGFloat = 20
    private let alarmOptions = [1, 3, 5, 7, 14, 30]
    
    // MARK: - Edit State
    private var selectedCategory: FoodCategory?
    private var selectedStorageMethod: StorageMethod?
    private var selectedAlarmDays: Int = 3
    private var selectedExpiryDate: Date?
    
    // MARK: - Layout State
    private var bottomToMemoValue: Constraint?
    private var bottomToMemoTextView: Constraint?
    
    // MARK: - Date Formatter
    private let popupDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US")
        f.dateFormat = "yyyy.MM.dd (EEE)"
        return f
    }()
    
    // MARK: - Container
    private let infoPopup = UIView().then {
        $0.backgroundColor = .asBackground
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Design.Radius.medium_20
    }
    private let infoTitle = UILabel().then {
        $0.text = "식재료 상세보기"
        $0.font = .as16BodyBold
        $0.textColor = .asBlack
        $0.textAlignment = .left
    }
    private let dismissBtn = UIButton().then {
        $0.setImage(.asXmark, for: .normal)
    }
    
    // MARK: - ScrollView
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let scrollContentView = UIView()
    
    // MARK: - Food Image
    private let foodImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .asGray5
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
    }
    private let cameraIconView = UIImageView().then {
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        $0.image = UIImage(systemName: "camera.fill", withConfiguration: config)
        $0.tintColor = .asGray2
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    // MARK: - Title Labels (Left Column)
    private let nameTitleLabel = UILabel().then {
        $0.text = "식재료명"
        $0.font = .as14BodyBold
        $0.textColor = .asMainOrange
    }
    private let categoryTitleLabel = UILabel().then {
        $0.text = "카테고리"
        $0.font = .as14BodyBold
        $0.textColor = .asMainOrange
    }
    private let storageTitleLabel = UILabel().then {
        $0.text = "보관방식"
        $0.font = .as14BodyBold
        $0.textColor = .asMainOrange
    }
    private let alarmTitleLabel = UILabel().then {
        $0.text = "알림일시"
        $0.font = .as14BodyBold
        $0.textColor = .asMainOrange
    }
    private let expiryTitleLabel = UILabel().then {
        $0.text = "유통기한"
        $0.font = .as14BodyBold
        $0.textColor = .asMainOrange
    }
    private let memoTitleLabel = UILabel().then {
        $0.text = "메모"
        $0.font = .as14BodyBold
        $0.textColor = .asMainOrange
    }
    
    // MARK: - View Mode Values (Right Column)
    private let nameValueLabel = UILabel().then {
        $0.font = .as14Body
        $0.textColor = .asBlack
        $0.numberOfLines = 1
    }
    private let categoryBadge = InsetLabel().then {
        $0.font = .as12CaptionBold
        $0.textColor = .asBlack
        $0.backgroundColor = .asAccentYellow
        $0.contentInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        $0.cornerRadius = 10
    }
    private let storageBadge = InsetLabel().then {
        $0.font = .as12CaptionBold
        $0.textColor = .asBlack
        $0.backgroundColor = .asAccentYellow
        $0.contentInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        $0.cornerRadius = 10
    }
    private let alarmValueLabel = UILabel().then {
        $0.font = .as14Body
        $0.textColor = .asBlack
    }
    private let expiryValueLabel = UILabel().then {
        $0.font = .as14BodyBold
        $0.textColor = .asBlack
    }
    private let expiryDDayBadge = InsetLabel().then {
        $0.apply(style: .dDayBadge)
    }
    private let memoValueLabel = UILabel().then {
        $0.font = .as14Body
        $0.textColor = .asBlack
        $0.numberOfLines = 0
    }
    
    // MARK: - Edit Mode Components (Right Column)
    private let nameTextField = UITextField().then {
        $0.font = .as14Body
        $0.textColor = .asBlack
        $0.borderStyle = .none
        $0.isHidden = true
    }
    private let nameUnderline = UIView().then {
        $0.backgroundColor = .asGray3
        $0.isHidden = true
    }
    private lazy var categoryDropdownBtn: UIButton = makeDropdownButton()
    private lazy var storageDropdownBtn: UIButton = makeDropdownButton()
    private lazy var alarmDropdownBtn: UIButton = makeDropdownButton()
    private let expiryDateBtn = UIButton().then {
        $0.setTitleColor(.asBlack, for: .normal)
        $0.titleLabel?.font = .as14BodyBold
        $0.contentHorizontalAlignment = .left
        $0.isHidden = true
    }
    private let calendarIconBtn = UIButton().then {
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        $0.setImage(UIImage(systemName: "calendar", withConfiguration: config), for: .normal)
        $0.tintColor = .asBlack
        $0.isHidden = true
    }
    private let memoTextView = UITextView().then {
        $0.font = .as14Body
        $0.textColor = .asBlack
        $0.backgroundColor = .asBackground
        $0.layer.borderColor = UIColor.asGray3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        $0.isHidden = true
    }
    private let memoPlaceholderLabel = UILabel().then {
        $0.text = "메모를 입력하세요 메모는 최대 3줄 입력가능합니다"
        $0.font = .as14Body
        $0.textColor = .asGray2
        $0.numberOfLines = 0
        $0.isHidden = true
    }
    
    // MARK: - Bottom Buttons
    private let editBtn = UIButton().then {
        $0.setTitle("수정하기", for: .normal)
        $0.setTitleColor(.asMainOrange, for: .normal)
        $0.titleLabel?.font = .as14BodyBold
        $0.layer.cornerRadius = 22
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.asMainOrange.cgColor
        $0.backgroundColor = .asBackground
    }
    private let consumeBtn = UIButton().then {
        $0.setTitle("소비완료", for: .normal)
        $0.setTitleColor(.asWhite, for: .normal)
        $0.titleLabel?.font = .as14BodyBold
        $0.backgroundColor = .asMainOrange
        $0.layer.cornerRadius = 22
    }
    
    // MARK: - Init
    
    init(foodInfo: FoodResponse) {
        self.foodInfo = foodInfo
        super.init()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        bind()
    }
    
    // MARK: - Layout
    
    override func setUpLayout() {
        view.addSubview(infoPopup)
        [infoTitle, dismissBtn, scrollView, editBtn, consumeBtn].forEach { infoPopup.addSubview($0) }
        scrollView.addSubview(scrollContentView)
        
        [foodImageView, cameraIconView,
         nameTitleLabel, nameValueLabel, nameTextField, nameUnderline,
         categoryTitleLabel, categoryBadge, categoryDropdownBtn,
         storageTitleLabel, storageBadge, storageDropdownBtn,
         alarmTitleLabel, alarmValueLabel, alarmDropdownBtn,
         expiryTitleLabel, expiryValueLabel, expiryDDayBadge, expiryDateBtn, calendarIconBtn,
         memoTitleLabel, memoValueLabel, memoTextView, memoPlaceholderLabel
        ].forEach { scrollContentView.addSubview($0) }
        
        setUpPopupConstraints()
        setUpHeaderConstraints()
        setUpScrollViewConstraints()
        setUpImageConstraints()
        setUpNameRowConstraints()
        setUpCategoryRowConstraints()
        setUpStorageRowConstraints()
        setUpAlarmRowConstraints()
        setUpExpiryRowConstraints()
        setUpMemoRowConstraints()
        setUpButtonConstraints()
        
        bottomToMemoTextView?.deactivate()
    }
    
    override func setUpUI() {
        view.backgroundColor = .asBlack.withAlphaComponent(0.7)
    }
    
    // MARK: - Constraints
    
    private func setUpPopupConstraints() {
        infoPopup.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
            make.height.lessThanOrEqualTo(UIScreen.main.bounds.height * 0.8)
        }
    }
    
    private func setUpHeaderConstraints() {
        infoTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28)
            make.leading.equalToSuperview().inset(contentPadding)
        }
        dismissBtn.snp.makeConstraints { make in
            make.centerY.equalTo(infoTitle)
            make.trailing.equalToSuperview().inset(contentPadding)
            make.size.equalTo(24)
        }
    }
    
    private func setUpScrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(infoTitle.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(editBtn.snp.top).offset(-16)
            make.height.equalTo(scrollContentView.snp.height).priority(.low)
        }
        scrollContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func setUpImageConstraints() {
        foodImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
        cameraIconView.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(foodImageView).inset(4)
            make.size.equalTo(24)
        }
    }
    
    private func setUpNameRowConstraints() {
        nameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImageView.snp.bottom).offset(rowSpacing + 4)
            make.leading.equalToSuperview().inset(contentPadding)
            make.width.equalTo(titleLabelWidth)
        }
        nameValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameTitleLabel)
            make.leading.equalTo(nameTitleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(contentPadding)
        }
        nameTextField.snp.makeConstraints { make in
            make.centerY.equalTo(nameTitleLabel)
            make.leading.equalTo(nameTitleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(contentPadding)
        }
        nameUnderline.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(nameTextField)
            make.height.equalTo(1)
        }
    }
    
    private func setUpCategoryRowConstraints() {
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTitleLabel.snp.bottom).offset(rowSpacing)
            make.leading.equalToSuperview().inset(contentPadding)
            make.width.equalTo(titleLabelWidth)
        }
        categoryBadge.snp.makeConstraints { make in
            make.centerY.equalTo(categoryTitleLabel)
            make.leading.equalTo(categoryTitleLabel.snp.trailing).offset(8)
        }
        categoryDropdownBtn.snp.makeConstraints { make in
            make.centerY.equalTo(categoryTitleLabel)
            make.leading.equalTo(categoryTitleLabel.snp.trailing).offset(8)
        }
    }
    
    private func setUpStorageRowConstraints() {
        storageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleLabel.snp.bottom).offset(rowSpacing)
            make.leading.equalToSuperview().inset(contentPadding)
            make.width.equalTo(titleLabelWidth)
        }
        storageBadge.snp.makeConstraints { make in
            make.centerY.equalTo(storageTitleLabel)
            make.leading.equalTo(storageTitleLabel.snp.trailing).offset(8)
        }
        storageDropdownBtn.snp.makeConstraints { make in
            make.centerY.equalTo(storageTitleLabel)
            make.leading.equalTo(storageTitleLabel.snp.trailing).offset(8)
        }
    }
    
    private func setUpAlarmRowConstraints() {
        alarmTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(storageTitleLabel.snp.bottom).offset(rowSpacing)
            make.leading.equalToSuperview().inset(contentPadding)
            make.width.equalTo(titleLabelWidth)
        }
        alarmValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(alarmTitleLabel)
            make.leading.equalTo(alarmTitleLabel.snp.trailing).offset(8)
        }
        alarmDropdownBtn.snp.makeConstraints { make in
            make.centerY.equalTo(alarmTitleLabel)
            make.leading.equalTo(alarmTitleLabel.snp.trailing).offset(8)
        }
    }
    
    private func setUpExpiryRowConstraints() {
        expiryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(alarmTitleLabel.snp.bottom).offset(rowSpacing)
            make.leading.equalToSuperview().inset(contentPadding)
            make.width.equalTo(titleLabelWidth)
        }
        expiryValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(expiryTitleLabel)
            make.leading.equalTo(expiryTitleLabel.snp.trailing).offset(8)
        }
        expiryDDayBadge.snp.makeConstraints { make in
            make.centerY.equalTo(expiryTitleLabel)
            make.leading.equalTo(expiryValueLabel.snp.trailing).offset(8)
        }
        expiryDateBtn.snp.makeConstraints { make in
            make.centerY.equalTo(expiryTitleLabel)
            make.leading.equalTo(expiryTitleLabel.snp.trailing).offset(8)
        }
        calendarIconBtn.snp.makeConstraints { make in
            make.centerY.equalTo(expiryTitleLabel)
            make.leading.equalTo(expiryDateBtn.snp.trailing).offset(6)
            make.size.equalTo(20)
        }
    }
    
    private func setUpMemoRowConstraints() {
        memoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(expiryTitleLabel.snp.bottom).offset(rowSpacing)
            make.leading.equalToSuperview().inset(contentPadding)
            make.width.equalTo(titleLabelWidth)
        }
        memoValueLabel.snp.makeConstraints { make in
            make.top.equalTo(memoTitleLabel)
            make.leading.equalTo(memoTitleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(contentPadding)
            bottomToMemoValue = make.bottom.equalToSuperview().inset(12).constraint
        }
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(memoTitleLabel)
            make.leading.equalTo(memoTitleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(contentPadding)
            make.height.equalTo(80)
            bottomToMemoTextView = make.bottom.equalToSuperview().inset(12).constraint
        }
        memoPlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(memoTextView).offset(8)
            make.leading.equalTo(memoTextView).offset(9)
            make.trailing.equalTo(memoTextView).inset(9)
        }
    }
    
    private func setUpButtonConstraints() {
        editBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(contentPadding)
            make.bottom.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        consumeBtn.snp.makeConstraints { make in
            make.leading.equalTo(editBtn.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(contentPadding)
            make.bottom.equalTo(editBtn)
            make.height.equalTo(44)
            make.width.equalTo(editBtn)
        }
    }
    
    // MARK: - Data
    
    private func setUpData() {
        foodImageView.setFoodImage(urlString: foodInfo.imageURL)
        
        let categoryName = foodInfo.categorys.first?.name ?? "알수없음"
        let storageName = foodInfo.storageMethod.displayName
        let alarmDays = foodInfo.expiryAlarm
        let dateString = formatDate(foodInfo.expiryDate)
        
        // View mode
        nameValueLabel.text = foodInfo.name
        categoryBadge.text = categoryName
        storageBadge.text = storageName
        alarmValueLabel.text = "\(alarmDays)일 전 알림"
        expiryValueLabel.text = dateString
        expiryDDayBadge.text = foodInfo.expiryDate.dDayString()
        memoValueLabel.text = foodInfo.memo
        
        // Edit mode state
        selectedCategory = foodInfo.categorys.first
        selectedStorageMethod = foodInfo.storageMethod
        selectedAlarmDays = alarmDays
        selectedExpiryDate = foodInfo.expiryDate
        
        nameTextField.text = foodInfo.name
        categoryDropdownBtn.setTitle(categoryName, for: .normal)
        storageDropdownBtn.setTitle(storageName, for: .normal)
        alarmDropdownBtn.setTitle("\(alarmDays)일 전", for: .normal)
        expiryDateBtn.setTitle(dateString, for: .normal)
        memoTextView.text = foodInfo.memo
    }
    
    // MARK: - Bind
    
    private func bind() {
        dismissBtn.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }.disposed(by: disposeBag)
        
        editBtn.rx.tap
            .subscribe(with: self) { owner, _ in
                if owner.isEditMode {
                    owner.isEditMode = false
                    owner.toggleEditMode(false)
                    owner.setUpData()
                } else {
                    owner.isEditMode = true
                    owner.toggleEditMode(true)
                }
            }.disposed(by: disposeBag)
        
        consumeBtn.rx.tap
            .subscribe(with: self) { owner, _ in
                if owner.isEditMode {
                    owner.isEditMode = false
                    owner.toggleEditMode(false)
                    // TODO: 수정사항 저장 처리
                } else {
                    owner.dismiss(animated: true)
                    // TODO: 소비완료 처리
                }
            }.disposed(by: disposeBag)
        
        categoryDropdownBtn.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.showCategoryPicker()
            }.disposed(by: disposeBag)
        
        storageDropdownBtn.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.showStorageMethodPicker()
            }.disposed(by: disposeBag)
        
        alarmDropdownBtn.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.showAlarmPicker()
            }.disposed(by: disposeBag)
        
        Observable.merge(
            expiryDateBtn.rx.tap.asObservable(),
            calendarIconBtn.rx.tap.asObservable()
        )
        .subscribe(with: self) { owner, _ in
            owner.showDatePicker()
        }.disposed(by: disposeBag)
        
        memoTextView.rx.text.orEmpty
            .subscribe(with: self) { owner, text in
                owner.memoPlaceholderLabel.isHidden = !owner.isEditMode || !text.isEmpty
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Toggle Edit Mode
    
    private func toggleEditMode(_ editing: Bool) {
        // View mode
        nameValueLabel.isHidden = editing
        categoryBadge.isHidden = editing
        storageBadge.isHidden = editing
        alarmValueLabel.isHidden = editing
        expiryValueLabel.isHidden = editing
        expiryDDayBadge.isHidden = editing
        memoValueLabel.isHidden = editing
        
        // Edit mode
        nameTextField.isHidden = !editing
        nameUnderline.isHidden = !editing
        categoryDropdownBtn.isHidden = !editing
        storageDropdownBtn.isHidden = !editing
        alarmDropdownBtn.isHidden = !editing
        expiryDateBtn.isHidden = !editing
        calendarIconBtn.isHidden = !editing
        memoTextView.isHidden = !editing
        cameraIconView.isHidden = !editing
        memoPlaceholderLabel.isHidden = !editing || !memoTextView.text.isEmpty
        
        // Toggle bottom constraints
        if editing {
            bottomToMemoValue?.deactivate()
            bottomToMemoTextView?.activate()
        } else {
            bottomToMemoTextView?.deactivate()
            bottomToMemoValue?.activate()
        }
        
        // Update button titles
        editBtn.setTitle(editing ? "수정취소" : "수정하기", for: .normal)
        consumeBtn.setTitle(editing ? "수정완료" : "소비완료", for: .normal)
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Pickers
    
    private func showCategoryPicker() {
        let alert = UIAlertController(title: "카테고리 선택", message: nil, preferredStyle: .actionSheet)
        for category in FoodCategory.mockList {
            alert.addAction(UIAlertAction(title: category.name, style: .default) { [weak self] _ in
                guard let self else { return }
                self.selectedCategory = category
                self.categoryDropdownBtn.setTitle(category.name, for: .normal)
            })
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showStorageMethodPicker() {
        let alert = UIAlertController(title: "보관방식 선택", message: nil, preferredStyle: .actionSheet)
        for method in StorageMethod.allCases {
            alert.addAction(UIAlertAction(title: method.displayName, style: .default) { [weak self] _ in
                guard let self else { return }
                self.selectedStorageMethod = method
                self.storageDropdownBtn.setTitle(method.displayName, for: .normal)
            })
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showAlarmPicker() {
        let alert = UIAlertController(title: "알림일시 선택", message: nil, preferredStyle: .actionSheet)
        for days in alarmOptions {
            alert.addAction(UIAlertAction(title: "\(days)일 전", style: .default) { [weak self] _ in
                guard let self else { return }
                self.selectedAlarmDays = days
                self.alarmDropdownBtn.setTitle("\(days)일 전", for: .normal)
            })
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showDatePicker() {
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let containerView = UIView()
        containerView.backgroundColor = .asBackground
        containerView.layer.cornerRadius = Design.Radius.medium_20
        containerView.clipsToBounds = true
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.date = selectedExpiryDate ?? Date()
        datePicker.locale = Locale(identifier: "ko_KR")
        
        let confirmBtn = UIButton()
        confirmBtn.setTitle("선택완료", for: .normal)
        confirmBtn.setTitleColor(.asWhite, for: .normal)
        confirmBtn.titleLabel?.font = .as14BodyBold
        confirmBtn.backgroundColor = .asMainOrange
        confirmBtn.layer.cornerRadius = 22
        
        view.addSubview(overlayView)
        overlayView.addSubview(containerView)
        [datePicker, confirmBtn].forEach { containerView.addSubview($0) }
        
        overlayView.snp.makeConstraints { $0.edges.equalToSuperview() }
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        datePicker.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(12)
        }
        confirmBtn.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(16)
        }
        
        let pickerDisposeBag = DisposeBag()
        
        confirmBtn.rx.tap
            .take(1)
            .subscribe(with: self) { owner, _ in
                owner.selectedExpiryDate = datePicker.date
                owner.expiryDateBtn.setTitle(owner.formatDate(datePicker.date), for: .normal)
                overlayView.removeFromSuperview()
            }.disposed(by: pickerDisposeBag)
        
        let tapGesture = UITapGestureRecognizer()
        overlayView.addGestureRecognizer(tapGesture)
        tapGesture.rx.event
            .subscribe(onNext: { gesture in
                let point = gesture.location(in: overlayView)
                if !containerView.frame.contains(point) {
                    overlayView.removeFromSuperview()
                }
            }).disposed(by: pickerDisposeBag)
    }
    
    // MARK: - Helpers
    
    private func makeDropdownButton() -> UIButton {
        let btn = UIButton()
        btn.setTitleColor(.asBlack, for: .normal)
        btn.titleLabel?.font = .as14Body
        btn.contentHorizontalAlignment = .left
        let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .medium)
        let chevron = UIImage(systemName: "chevron.down", withConfiguration: config)
        btn.setImage(chevron, for: .normal)
        btn.tintColor = .asBlack
        btn.semanticContentAttribute = .forceRightToLeft
        btn.isHidden = true
        return btn
    }
    
    private func formatDate(_ date: Date) -> String {
        return popupDateFormatter.string(from: date).uppercased()
    }
}
