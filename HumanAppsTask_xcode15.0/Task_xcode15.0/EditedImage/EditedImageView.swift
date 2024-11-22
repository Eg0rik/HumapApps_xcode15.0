//
//  EditedView.swift
//  HumanAppsTask
//
//  Created by MAC on 11/14/24.
//

import UIKit
import SnapKit


class EditedImageView: MovableView {
    
    //MARK: - Public properties
    
    //MARK: - Private properties
    private var originalImage: UIImage?
    
    //MARK: - Views
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
        originalImage = image
    }
    
    func getImage() -> UIImage? {
        captureView()
    }
    
    func delteImage() {
        imageView.image = nil
        originalImage = nil
    }
    
    func setDefaultTransform() {
        transform = .identity
    }
    
    func setOriginalImage() {
        imageView.image = originalImage
    }
    
    func setFilter(_ filter: FilterType) {
        guard let originalImage else { return }
        
        imageView.image = createNewImageWithFilter(originalImage, filter: filter)
    }
}

//MARK: - Private methods
private extension EditedImageView {
    func setupView() {
        addSubview(imageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func createNewImageWithFilter(_ image: UIImage, filter : FilterType) -> UIImage {
        guard filter != .original else { return image }
        
        let filter = CIFilter(name: filter.rawValue)
        
        let ciInput = CIImage(image: image)
        
        filter?.setValue(ciInput, forKey: "inputImage")
        
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        
        return UIImage(cgImage: cgImage!)
    }
}

#Preview {
    makeControllerForPreview()
}
