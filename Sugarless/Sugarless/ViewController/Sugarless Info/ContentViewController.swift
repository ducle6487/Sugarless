//
//  ContentViewController.swift
//  Sugarless
//
//  Created by Hồ Trần Gia Khánh on 12/29/20.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var NavigationTittle: UINavigationItem!
    @IBOutlet weak var lbTopContent: UILabel!
    @IBOutlet weak var lbTittle: UILabel!
    @IBOutlet weak var lbBotContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        NavigationTittle.title = "KIỂM SOÁT TIỂU ĐƯỜNG VÀO MÙA ĐÔNG KIỂM SOÁT TIỂU ĐƯỜNG VÀO MÙA ĐÔNG"
        //
        lbTopContent.adjustsFontSizeToFitWidth = true
        lbTopContent.numberOfLines = 50
        lbTopContent.text = """
            Do đặc thù thời tiết, vào mùa đông lượng HbA1c  có khuynh hướng gia tăng. (HbA1c là lượng đường kèm theo protein tích tụ trong hồng cầu). Cơ thể cần nhiều insulin để chuyển hóa glucose thành năng lượng. Vấn đề này sẽ trở nên nghiêm trọng hơn khi bạn bị cảm cúm. Khi đó cơ thể tiết ra hooc-môn kháng bệnh, lượng hooc môn này sẽ giúp cơ thể chống lại những tác nhân gây bệnh đồng thời cũng khiến insulin trong người khó hoạt động.

            Việc chăm sóc người bệnh tiểu đường vào mùa đông cần được quan tâm và lưu ý hơn những thời gian khác.
            """
        //
        lbTittle.adjustsFontSizeToFitWidth = true
        lbTittle.numberOfLines = 2
        lbTittle.text = "Duy trì luyện tập thể dục là cách tốt để kiểm soát lượng đường huyết vào mùa đông"
        //
        lbBotContent.adjustsFontSizeToFitWidth = true
        lbBotContent.numberOfLines = 100
        lbBotContent.text = """
            Biến chứng tiểu đường vào mùa đông

            Trời lạnh làm cho huyết áp tăng cao, các biến chứng bệnh sẽ tăng lên. Huyết áp cao có thể dẫn tới tình trạng vỡ mạch máu gây xuất huyết não. Ngoài ra mạch máu bị xơ cứng, làm giảm khả năng đàn hồi, kèm theo huyết áp cao gây nên vấn đề hình thành mảng xơ vữa làm rối loạn quá trình đông máu. Các cục máu đông này sẽ làm đình trệ tuần hoàn, gây nên tai biến mạch máu não, nhồi máu cơ tim…

            Vào mùa đông, đa số mọi người có thói quen ăn nhiều lên và vận động ít đi khiến cho lượng đường huyết tăng lên.

            Giải pháp kiểm soát lượng đường huyết vào mùa đông

                – Dự phòng nhiễm trùng

            Bị nhiễm cảm lạnh hoặc cúm sẽ là vấn đề nghiêm trọng nếu bạn đang bị tiểu đường bởi chúng có thể gây ra những vấn đề sức khỏe nghiêm trọng sau này. Các bệnh nhiễm trùng có thể diễn biến rất nhanh và trong một số trường hợp có thể dẫn tới nhiễm xeton axit.

            Người  bệnh tiểu đường nên tránh tiếp xúc với người ốm và thường xuyên rửa tay để tránh mắc các bệnh dễ lây nhiễm.

            – Cố gắng duy trì luyện tập

            Trong suốt mùa đông, mọi người đều có xu hướng lười vận động và điều này là nguy cơ khiến lượng đường huyết tăng cao. Thay vì luyện tập ngoài trời, bạn có thể duy trì thói quen đi bộ trong nhà hoặc tham khảo những bài hướng dẫn luyện tập thể thao đơn giản hàng ngày.
            Bạn cũng có thể chia nhỏ thời gian luyện tập của mình 10 phút vào buổi sáng và 10 phút cho buổi tối. Cố gắng để không ngừng hẳn việc luyện tập vào mùa đông.

              – Chăm sóc bàn chân

            Vào mùa đông, đôi bàn chân của người bệnh cần sự quan tâm đặc biệt hơn. Độ ẩm thấp trong mùa đông khiến gây ra tình trạng khô da. Nếu chức năng tuần hoàn của bạn kém hoặc bạn bị các bệnh lý về thần kinh ngoại biên, bạn có thể sẽ không cảm nhận được cái lạnh thông qua bàn chân. Nguy cơ lở loét, nhiễm trùng và hoại tử chân ở người bệnh tiểu đường trong mùa đông sẽ cao hơn.

                – Tránh tăng cân trong mùa đông

            Bạn cần theo dõi kỹ lượng thực phẩm giàu carbohydrate mà bạn ăn trong mùa đông và thay thế chúng bằng các loại thực phẩm khác. Vào các dịp lễ tết thì vấn đề dinh dưỡng cũng cần được bạn chú ý một cách cẩn trọng hơn.

            """
    }
    

}
