package kr.co.ubcn.multivm.controller;

import kr.co.ubcn.multivm.mapper.ReleaseMapper;
import kr.co.ubcn.multivm.mapper.StockMapper;
import kr.co.ubcn.multivm.mapper.StoreMapper;
import kr.co.ubcn.multivm.model.*;
import kr.co.ubcn.multivm.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/board")
public class BoardController {
    @Autowired
    BoardService boardService;
    @Autowired
    ReleaseMapper releaseMapper;
    @Autowired
    StoreMapper storeMapper;
    @Autowired
    StockMapper stockMapper;

    Logger logger = LoggerFactory.getLogger(ProductController.class);

    @GetMapping("/store")
    public ModelAndView serviceStore(ModelAndView mav,HttpServletRequest request){
        return boardService.setBoardPage(mav, request, "store");
    }
    @GetMapping("/release")
    public ModelAndView serviceRelease(ModelAndView mav,HttpServletRequest request){
        return boardService.setBoardPage(mav, request, "release");
    }
    @GetMapping("/stock")
    public ModelAndView serviceStock(ModelAndView mav,HttpServletRequest request){
        return boardService.setBoardPage(mav, request, "stock");
    }
    @PostMapping("/ajax/getSearchReleaseList.do")
    public List<Release> ajaxGetSearchReleaseList(@RequestParam Map<String, Object> param, HttpSession session){
        User loginUser = (User)session.getAttribute("loginUser");
        param.put("auth",loginUser.getAuth());
        param.put("userSeq",loginUser.getSeq());
        return releaseMapper.getReleaseList(param);
    }
    @PostMapping("/ajax/getSearchStoreList.do")
    public List<Store> ajaxGetSearchStoreList(@RequestParam Map<String, Object> param, HttpSession session){
        User loginUser = (User)session.getAttribute("loginUser");
        param.put("auth",loginUser.getAuth());
        param.put("userSeq",loginUser.getSeq());
        return storeMapper.getStoreList(param);
    }

    @PostMapping("/ajax/getSearchStockList.do")
    public List<Stock> ajaxGetSearchStockList(@RequestParam Map<String, Object> param, HttpSession session){
        User loginUser = (User)session.getAttribute("loginUser");
        param.put("auth",loginUser.getAuth());
        param.put("userSeq",loginUser.getSeq());
        return stockMapper.getStockList(param);
    }

    @PostMapping("/ajax/detailProductStock.do")
    public Stock ajaxDetailProductStock(@RequestParam Map<String, Object> param){
        return stockMapper.getStockInfo(param);
    }
    @PostMapping("/ajax/editProductStock.do")
    public String ajaxEditProductStock(HttpSession session, Release release){
        release.setModifyUserSeq((Integer) session.getAttribute("userSeq"));
        boolean result = releaseMapper.insertRelease(release);
        if(result){
            stockMapper.updateStock(release);
        }

        return result?"수정되었습니다.":"에러 발생";
    }




}
