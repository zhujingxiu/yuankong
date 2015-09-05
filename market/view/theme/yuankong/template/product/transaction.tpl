<?php if ($transactions) { ?>
<table class="buy-jl" width="100%">
    <thead>
        <tr>
            <th>买家</th>
            <th>规格/型号</th>
            <th>数量</th>
            <th>会员价</th>
            <th>成交时间</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($transactions as $item) { ?>
        <tr>
            <td><?php echo $item['mobile_phone'] ?></td>
            <td>
                <?php echo $item['options'] ?>
            </td>
            <td><?php echo $item['quantity'] ?></td>
            <td><em class="c_red"><?php echo $item['price'] ?></em></td>
            <td><?php echo $item['date_added'] ?></td>
        </tr>
        <?php } ?>
    </tbody>
</table>

<div class="pagination"><?php echo $pagination; ?></div>
<?php } else { ?>
<div class="content"><?php echo $text_no_records; ?></div>
<?php } ?>
