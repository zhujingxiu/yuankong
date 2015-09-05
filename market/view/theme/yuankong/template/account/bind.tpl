<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<div class="register-w f_s fix" id="main">
    <?php if( $SPAN[0] ): ?>
    <div class="<?php echo $SPAN[0];?> aside">
    <?php echo $column_left; ?>
    </div>
    <?php endif; ?>

    <div class="article">
        <div class="userbox4">
            <div class="p30">
                <h3 class="index-t"><b class="f_l">绑定手机</b></h3>
                <div class="bind_content mt20">
                    <div class="email_bind mobile border_bottom">
                        <span class="img"></span>
                        <span class="mid"><em>手机号绑定</em><br>188****1766</span>
                        <span class="btn"><input type="button" onclick="location.href = './yz_administration_self.php?bdmobile=1&amp;act=4&amp;bd=6'" class="bind_click" value="修改" style="background:#BAB7B7;cursor:default;" disabled="true"></span>
                    </div>

                    <!--===安全验证  手机验证码===-->
                    <div class="reset_line">
                        <ul>
                            <li class="first cur"><em>1</em><b></b><span>身份验证</span></li>
                            <li><em>2</em><b></b><span>修改手机号</span></li>
                            <li class="last"><em>3</em><span>完成</span></li>
                        </ul>
                    </div>
                    <!--===安全验证  身份验证===-->
                    <form id="company-form" action="<?php echo $action ?>" method="post" enctype="multipart/form-data">

                        <!--<p id="tishi" style="color:#f33;padding-left:112px;margin-bottom:5px;">&nbsp;</p>-->
                        <div style="display:block;" class="reset_content_mobile mobile_step1">                  
                            <div class="mobile_code">
                                <span>输入登陆密码</span>
                                <input type="password" onkeyup="checkPwd()" class="user_txt" id="pwd" name="pwd">

                                <!--<input type="text" name="mobileNumber" class="user_txt">-->
                                <div id="pwdmessage" class="message"></div>
                            </div>
                            <div class="mobile_code">
                                <span>请输入验证码</span>
                                <input type="text" onkeyup="checkPwd()" id="yzm" name="yzm" class="code">
                                <img width="80" height="24" onclick="newverifypic()" id="passport" src="http://www.to8to.com/passport.php?t=1384331291"><a href="javascript:newverifypic()">换一张</a>
                                <div id="yzmmessage" class="message"></div>
                                <!--<img src="http://www.to8to.com/passport.php?t=1384331291" id="passport" class="passport" onclick="newverifypic()"><a href="javascript:newverifypic()" class="repassport" style="font-size:12px;" width='93' height='24'>看不清？换一张</a>-->
                                <!--<input type="button" class="btn_post_code" value="短信获取验证码" />-->

                            </div>
                            <input type="hidden" value="6" name="bd_val">
                            <input type="submit" class="next_bit" value="提交">
                        </div>
                    </form>

                </div>
                
            </div>
        </div>
    </div> 
    <?php if( $SPAN[2] ): ?>
    <div class="<?php echo $SPAN[2];?>">    
        <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
</div> 


<?php echo $footer; ?> 