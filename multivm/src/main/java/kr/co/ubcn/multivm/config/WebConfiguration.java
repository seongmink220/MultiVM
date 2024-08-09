package kr.co.ubcn.multivm.config;

import kr.co.ubcn.multivm.intercepter.AuthIntercepter;
import kr.co.ubcn.multivm.intercepter.CompanyUserIntercepter;
import kr.co.ubcn.multivm.intercepter.LoginCheckIntercepter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;


@Configuration
public class WebConfiguration implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginCheckIntercepter())
                .excludePathPatterns( "/","/login","/detail/**","/notice/**","/admin/**","/resources/**","/css/**", "/fonts/**", "/plugin/**", "/scripts/**","/images/**","/image/**","/js/**","/error/**", "/api/**", "/image/product/**");
                //.addPathPatterns("/*","/product","/test");
        registry.addInterceptor(new AuthIntercepter())
                .addPathPatterns("/product/copy");
        registry.addInterceptor(new CompanyUserIntercepter())
                .addPathPatterns("/company/orig").addPathPatterns("/company/user");
    }

    @Bean
    public TilesConfigurer tilesConfigurer(){
        final TilesConfigurer configurer = new TilesConfigurer();

        configurer.setDefinitions(new String[]{
                "/WEB-INF/tiles.xml"
        });
        configurer.setCheckRefresh(true);
        return configurer;
    }
    @Bean
    public TilesViewResolver tilesViewResolver(){
        final TilesViewResolver tilesViewResolver = new TilesViewResolver();
        tilesViewResolver.setViewClass(TilesView.class);
        tilesViewResolver.setOrder(1);
        return tilesViewResolver;
    }
    @Bean
    public CommonsMultipartResolver multipartResolver(){
        CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver();
        commonsMultipartResolver.setDefaultEncoding("UTF-8");
        commonsMultipartResolver.setMaxUploadSizePerFile(101 * 1024 * 1024); //100MB제한
        return commonsMultipartResolver;
    }



}
