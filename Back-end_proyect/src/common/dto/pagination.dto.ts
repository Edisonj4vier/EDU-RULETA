import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, IsOptional, IsPositive, Min } from 'class-validator';

export class PaginationDto {
  @ApiProperty({
    required: false,
    default: 10,
    description: 'El número de elementos a devolver',
  })
  @IsOptional()
  @IsPositive()
  @IsNumber()
  @Min(1)
  limit?: number;

  @ApiProperty({
    required: false,
    default: 0,
    description: 'El número de elementos a saltar',
  })
  @IsOptional()
  @Min(0)
  @IsNumber()
  offset?: number;
}
